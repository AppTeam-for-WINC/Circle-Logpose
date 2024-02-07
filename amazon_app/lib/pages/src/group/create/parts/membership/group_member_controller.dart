import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupAddMemberDataProvider =
    StateNotifierProvider<GroupAddData, UserProfile?>(
  (ref) => GroupAddData(),
);

class GroupAddData extends StateNotifier<UserProfile?> {
  GroupAddData() : super(null) {
    groupNameController.addListener(() {
      memberController(groupNameController.text);
    });
  }

  TextEditingController groupNameController = TextEditingController();
  String? accountId;
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  Future<void> memberController(String? accountId) async {
    if (accountId == null || accountId.isEmpty) {
      return;
    }
    users = await UserController.readWithAccountId(accountId);
    if (users != null && users!.isNotEmpty) {
      user = users!.first;
      username = user!.name;
      userImage = user!.image;
      userDescription = user!.description;
      state = user;
    } else {
      state = null;
    }
  }
}
