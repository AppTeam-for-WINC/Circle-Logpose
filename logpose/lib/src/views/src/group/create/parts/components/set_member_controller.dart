import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../models/user/user.dart';
import '../../../../../../services/database/crud/user_controller.dart';

/// Switch mode of delete set member.
final setMemberDeleteModeProvider =
    StateProvider.autoDispose<bool>((ref) => false);

/// Used to set group membership.
final setGroupMemberListProvider = StateNotifierProvider.autoDispose<
    _GroupMemberListNotifier, List<UserProfile>>(
  (ref) => _GroupMemberListNotifier(),
);

/// グループ作成の際にメンバーリストを管理。
class _GroupMemberListNotifier extends StateNotifier<List<UserProfile>> {
  _GroupMemberListNotifier() : super([]);

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

/// グループ作成画面におけるメンバーに表示されるメンバーリストに追加する情報を管理。
final setGroupMemberDataAndGroupDataProvider = StateNotifierProvider
    .autoDispose<_SetGroupMemberAndGroupData, UserProfile?>(
  (ref) => _SetGroupMemberAndGroupData(),
);

class _SetGroupMemberAndGroupData extends StateNotifier<UserProfile?> {
  _SetGroupMemberAndGroupData() : super(null) {
    groupNameController.addListener(() {
      memberController(groupNameController.text);
    });
  }

  // リファクタリング時にgroupNameControllerを別のクラスで管理する必要がある。
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
