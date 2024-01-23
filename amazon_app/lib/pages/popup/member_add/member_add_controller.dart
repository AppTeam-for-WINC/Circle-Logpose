import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/invitation/invitation_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String?> getGroupInvitationLink(String groupId) async {
  final invitationData = await GroupInvitationController.create(groupId);
  final invitationLink = invitationData.invitationLink;
  return invitationLink;
}

class MemberAddData extends StateNotifier<UserProfile?> {
  MemberAddData() : super(null) {
    accountIdController.addListener(accountDataController);
  }

  TextEditingController accountIdController = TextEditingController();
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  Future<void> accountDataController() async {
    await accountIdLengthChecker();
    await memberAddController();
  }

  Future<String?> accountIdLengthChecker() async {
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

  Future<void> memberAddController() async {
    final myDocId = await AuthController.getCurrentUserId();
    final myAccount = await UserController.read(myDocId!);

    final accountId = accountIdController.text;
    users = await UserController.readWithAccountId(accountId);

    //アカウントIDが見つからない場合は、nullを返す。
    if (users!.isEmpty) {
      username = null;
      userImage = null;
      userDescription = null;
      state = null;
    } else {
      user = users!.first;
      //自分のアカウントを検索した場合は、何も返さない。
      if (myAccount.accountId != user!.accountId) {
        username = user!.name;
        userImage = user!.image;
        userDescription = user!.description;
        state = user;
      }
    }
  }
}
