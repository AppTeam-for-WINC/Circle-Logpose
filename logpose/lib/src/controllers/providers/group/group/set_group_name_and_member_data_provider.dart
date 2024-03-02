import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';
import '../../../../services/database/user_controller.dart';

/// グループ作成画面におけるメンバーに表示されるメンバーリストに追加する情報を管理。
final setGroupNameAndMemberDataProvider = StateNotifierProvider
    .autoDispose<_SetGroupAndMemberData, UserProfile?>(
  (ref) => _SetGroupAndMemberData(),
);

class _SetGroupAndMemberData extends StateNotifier<UserProfile?> {
  _SetGroupAndMemberData() : super(null) {
    groupNameController.addListener(() {
      _readMemberData(groupNameController.text);
    });
  }

  TextEditingController groupNameController = TextEditingController();
  
  String? accountId;
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  Future<void> _readMemberData(String? accountId) async {
    if (accountId == null || accountId.isEmpty) {
      return;
    }
    users = await UserController.readWithAccountIdList(accountId);
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
