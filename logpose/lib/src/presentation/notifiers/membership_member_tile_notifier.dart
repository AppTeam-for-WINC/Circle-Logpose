import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';
import '../../domain/providers/group/members/listen_group_member_profile_list_provider.dart';

import '../components/common/group_member_tile/group_member_tile.dart';

final membershipMemberTileNotifierProvider =
    StateNotifierProvider.family<_MembershipMemberTileNotifier, Widget, String>(
  _MembershipMemberTileNotifier.new,
);

class _MembershipMemberTileNotifier extends StateNotifier<Widget> {
  _MembershipMemberTileNotifier(this.ref, this.groupId)
      : super(const SizedBox.shrink()) {
    _listenMembershipTile();
  }

  final Ref ref;
  final String groupId;

  Widget _listenMembershipTile() {
    return ref.watch(listenGroupMembershipProfileListProvider(groupId)).when(
          data: (List<UserProfile?> membershipProfileList) {
            if (membershipProfileList.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: membershipProfileList.map((membershipProfile) {
                if (membershipProfile == null) {
                  return const SizedBox.shrink();
                }
                return GroupMemberTile(
                  memberProfile: membershipProfile,
                   groupRoleType: GroupRoleType.membership,
                  groupId: groupId,
                );
              }).toList(),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Text('$error'),
        );
  }
}
