import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupAdminMemberProfileProvider =
    FutureProvider<UserProfile>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final user = await UserController.read(userDocId);

  return user;
});


final groupMemberListProvider =
    StateNotifierProvider<GroupMemberListNotifier, List<UserProfile>>(
        (ref) => GroupMemberListNotifier(),);

///メンバーリストを追加するためのStateNotifier
class GroupMemberListNotifier extends StateNotifier<List<UserProfile>> {
  GroupMemberListNotifier() : super([]);

  void addMember(UserProfile newMember) {
    state = [...state, newMember];
  }

  void resetMemberList() {
    state = [];
  }
}
