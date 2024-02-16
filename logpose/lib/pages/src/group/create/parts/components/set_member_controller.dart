import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../database/user/user.dart';
import '../../../../../../database/user/user_controller.dart';

/// Switch mode of delete set member.
final setMemberDeleteModeProvider =
    StateProvider.autoDispose<bool>((ref) => false);

/// Used to set group membership.
final setGroupMemberListProvider = StateNotifierProvider.autoDispose<
    GroupMemberListNotifier, List<UserProfile>>(
  (ref) => GroupMemberListNotifier(),
);

/// グループ作成の際にメンバーリストを管理。
class GroupMemberListNotifier extends StateNotifier<List<UserProfile>> {
  GroupMemberListNotifier() : super([]);

  void addMember(UserProfile newMember) {
    state = [...state, newMember];
  }

  void removeMember(String accountId) {
    state = state.where((member) => member.accountId != accountId).toList();
  }

  void resetMemberList() {
    state = [];
  }
}

/// グループ作成におけるメンバーリストに追加する情報を管理。
final groupAddMemberDataProvider =
    StateNotifierProvider.autoDispose<GroupAddData, UserProfile?>(
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
