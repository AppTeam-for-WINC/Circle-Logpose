import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupAddMemberDataProvider = StateNotifierProvider<GroupAddData, UserProfile?>(
  (ref) => GroupAddData(),
);

class GroupAddData extends StateNotifier<UserProfile?> {
  GroupAddData() : super(null) {
    groupNameController.addListener(groupDataController);
  }

  TextEditingController groupNameController = TextEditingController();
  String? accountId;
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  Future<void> groupDataController() async {
    await memberController(accountId);
  }

  Future<void> memberController(String? accountId) async {
    if (accountId == null) {
      return;
    }
    users = await UserController.readWithAccountId(accountId);
    user = users!.first;
    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    state = users!.isNotEmpty ? users!.first : null;
  }
}