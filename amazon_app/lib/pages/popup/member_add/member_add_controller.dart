import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberAddDataProvider = Provider<MemberAddData>(MemberAddData.new);

class MemberAddData {
  MemberAddData(this.ref) {
    accountIdController.addListener(accountDataController);
    memberAddController();
  }

  final Ref ref;
  TextEditingController accountIdController = TextEditingController();
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  void testFunc(){}

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
    final accountId = accountIdController.text;
    users = await UserController.readWithAccountId(accountId);
    user = users!.first;
    
    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
  }
}
