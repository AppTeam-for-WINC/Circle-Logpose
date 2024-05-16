import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../validator/validator_controller.dart';

import '../../usecase/auth_use_case.dart';
import '../../usecase/group_membership_use_case.dart';
import '../../usecase/user_use_case.dart';

import '../validator/validator_controller_provider.dart';

final setSearchUserDataProvider =
    StateNotifierProvider.family<_SearchUserNotifier, UserProfile?, String?>(
  _SearchUserNotifier.new,
);

class _SearchUserNotifier extends StateNotifier<UserProfile?> {
  _SearchUserNotifier(this.ref, this.groupId)
      : authController = ref.read(authUseCaseProvider),
        userController = ref.read(userUseCaseProvider),
        membershipController = ref.read(groupMembershipUseCaseProvider),
        validator = ref.read(validatorControllerProvider),
        super(null) {
    accountIdController.addListener(() {
      _accountDataController(groupId);
    });
  }

  final StateNotifierProviderRef<_SearchUserNotifier, UserProfile?> ref;
  final String? groupId;
  final AuthUseCase authController;
  final UserUseCase userController;
  final GroupMembershipUseCase membershipController;
  final ValidatorController validator;

  TextEditingController accountIdController = TextEditingController();
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;
  Set<String> addedMemberIds = {};

  void resetState() {
    accountIdController.text = '';
    state = null;
  }

  void setMemberState() {
    final accountId = accountIdController.text;
    addedMemberIds.add(accountId);
  }

  Future<void> _accountDataController(String? groupId) async {
    _validateAccountId();
    await _memberAddController(groupId);
  }

  String? _validateAccountId() {
    final accountId = accountIdController.text;
    return validator.validateAccountId(accountId);
  }

  Future<void> _memberAddController(String? groupId) async {
    final myDocId = await authController.fetchCurrentUserId();
    final myAccount = await userController.fetchUserProfile(myDocId);
    final accountId = accountIdController.text;
    user = await userController.fetchUserProfileWithAccountId(accountId);

    // アカウントIDが見つからない場合は、nullを返す。
    if (user == null) {
      state = null;
      return;
    }

    // 自分のアカウントを検索した場合は、何も返さない。
    if (myAccount.accountId == user!.accountId) {
      state = null;
      return;
    }

    // 既にGroup memberの場合は何も返さない。
    if (groupId != null) {
      return _noReturnIfUserIsMember(accountId);
    }

    // 既に追加済みのメンバーの場合は何も返さない。
    if (addedMemberIds.contains(accountId)) {
      state = null;
      return;
    }

    return _setUserProfile();
  }

  Future<void> _noReturnIfUserIsMember(String accountId) async {
    final userId = await userController.fetchUserDocIdWithAccountId(accountId);
    final isAlreadyMember =
        await membershipController.doesMemberExist(groupId!, userId);

    if (isAlreadyMember) {
      state = null;
      return;
    }
  }

  void _setUserProfile() {
    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    state = user;
    return;
  }
}
