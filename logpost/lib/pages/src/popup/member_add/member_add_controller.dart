import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpost/database/group/membership/group_membership_controller.dart';

import '../../../../database/auth/auth_controller.dart';
import '../../../../database/group/invitation/invitation_controller.dart';
import '../../../../database/user/user.dart';
import '../../../../database/user/user_controller.dart';
import '../../../../validation/validation.dart';
// import '../../group/create/parts/components/set_member_controller.dart';

class GroupInvitationLink {
  GroupInvitationLink._internal();
  static final GroupInvitationLink _instance = GroupInvitationLink._internal();
  static GroupInvitationLink get instance => _instance;

  static Future<String?> readGroupInvitationLink(String groupId) async {
    try {
      final invitationData = await GroupInvitationController.create(groupId);
      final invitationLink = invitationData.invitationLink;
      return invitationLink;
    } on FirebaseException catch (e) {
      throw Exception('Failed to read invitation link. $e');
    }
  }
}

final memberAddProvider =
    StateNotifierProvider.family<MemberAddData, UserProfile?, String?>(
  (ref, groupId) => MemberAddData(groupId),
);

class MemberAddData extends StateNotifier<UserProfile?> {
  MemberAddData(String? groupId) : super(null) {
    accountIdController.addListener(() {
      _accountDataController(groupId);
    });
  }

  late final WidgetRef ref;
  TextEditingController accountIdController = TextEditingController();
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  void resetState() {
    accountIdController.text = '';
    state = null;
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
      final isExistMember = await GroupMembershipController.checkMemberIsExist(
        groupId: groupId,
        userDocId: userId,
      );

      if (isExistMember) {
        username = null;
        userImage = null;
        userDescription = null;
        state = null;
        return;
      }
    }

    // 一度追加したメンバーは何も返さない。
    // 以下のコードは、refの初期化が出来ていないためバグが発生する。
    // ref.watch(setGroupMemberListProvider).map((member) {
    //   if (accountId == member.accountId) {
    //     username = null;
    //     userImage = null;
    //     userDescription = null;
    //     state = null;
    //     return;
    //   }
    // });

    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    state = user;
    return;
  }
}
