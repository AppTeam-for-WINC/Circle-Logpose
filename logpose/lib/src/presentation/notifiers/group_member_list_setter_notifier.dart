import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

final groupMemberListSetterNotifierProvider = StateNotifierProvider.autoDispose<
    _GroupMemberListSetterNotifier, List<UserProfile>>(
  (ref) => _GroupMemberListSetterNotifier(),
);

class _GroupMemberListSetterNotifier extends StateNotifier<List<UserProfile>> {
  _GroupMemberListSetterNotifier() : super([]);

  void addMember(UserProfile newMember) {
    state = [...state, newMember];
  }

  void removeMember(String accountId) {
    state = state.where((member) => member.accountId != accountId).toList();
  }
}
