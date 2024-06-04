import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../components/common/group_member_tile/group_member_tile.dart';

import '../providers/group/members/listen_group_member_profile_list_provider.dart';

final membershipMemberTileNotifierProvider = StateNotifierProvider.family<
    _MembershipMemberTileNotifier, List<Widget>, String>(
  _MembershipMemberTileNotifier.new,
);

class _MembershipMemberTileNotifier extends StateNotifier<List<Widget>> {
  _MembershipMemberTileNotifier(this.ref, this.groupId) : super([]) {
    _initialize();
  }

  final Ref ref;
  final String groupId;

  void _initialize() {
    state = _buildMembershipTile();
  }

  List<Widget> _buildMembershipTile() {
    return ref.watch(listenGroupMembershipProfileListProvider(groupId)).when(
          data: _buildGroupMemberTileList,
          loading: () => [],
          error: (error, stack) => [Text('$error')],
        );
  }

  List<Widget> _buildGroupMemberTileList(
    List<UserProfile?> membershipProfileList,
  ) {
    if (membershipProfileList.isEmpty) {
      return [];
    }

    return membershipProfileList.map((membershipProfile) {
      if (membershipProfile == null) {
        return const SizedBox.shrink();
      }
      return GroupMemberTile(
        memberProfile: membershipProfile,
        groupRoleType: GroupRoleType.membership,
        groupId: groupId,
      );
    }).toList();
  }
}
