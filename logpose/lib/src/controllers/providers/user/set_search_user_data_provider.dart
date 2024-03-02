import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/max_length_validation.dart';
import '../../../models/user/user.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/group_membership_controller.dart';
import '../../../services/database/user_controller.dart';

final setSearchUserDataProvider =
    StateNotifierProvider.family<_SearchUserData, UserProfile?, String?>(
  (ref, groupId) => _SearchUserData(groupId),
);

class _SearchUserData extends StateNotifier<UserProfile?> {
  _SearchUserData(String? groupId) : super(null) {
    accountIdController.addListener(() {
      _accountDataController(groupId);
    });
  }

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

  // 追加するメンバーをセットに追加
  void setMemberState() {
    final accountId = accountIdController.text;
    addedMemberIds.add(accountId);
  }

  Future<void> _accountDataController(String? groupId) async {
    await _accountIdLengthChecker();
    await _memberAddController(groupId);
  }

  Future<String?> _accountIdLengthChecker() async {
    final accountId = accountIdController.text;
    const maxLength64Validation = MaxLength64Validation();

    final accountIdMaxLength64Validation = maxLength64Validation.validate(
      accountId,
      'accountId',
    );
    if (accountIdMaxLength64Validation) {
      return null;
    }
    return 'Maximum length is 64 characters.';
  }

  Future<void> _memberAddController(String? groupId) async {
    final myDocId = await AuthController.getCurrentUserId();
    final myAccount = await UserController.read(myDocId!);

    final accountId = accountIdController.text;
    user = await UserController.readWithAccountId(accountId);

    // アカウントIDが見つからない場合は、nullを返す。
    if (user == null) {
      username = null;
      userImage = null;
      userDescription = null;
      state = null;
      return;
    }

    // 自分のアカウントを検索した場合は、何も返さない。
    if (myAccount.accountId == user!.accountId) {
      username = null;
      userImage = null;
      userDescription = null;
      state = null;
      return;
    }

    // 既にGroup memberの場合は何も返さない。
    if (groupId != null) {
      final userId = await UserController.readUserDocIdWithAccountId(accountId);
      final isAlreadyMember =
          await GroupMembershipController.checkMemberIsExist(
        groupId: groupId,
        userDocId: userId,
      );

      if (isAlreadyMember) {
        username = null;
        userImage = null;
        userDescription = null;
        state = null;
        return;
      }
    }

    // 既に追加済みのメンバーの場合は何も返さない。
    if (addedMemberIds.contains(accountId)) {
      username = null;
      userImage = null;
      userDescription = null;
      state = null;
      return;
    }

    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    state = user;
    return;
  }
}
