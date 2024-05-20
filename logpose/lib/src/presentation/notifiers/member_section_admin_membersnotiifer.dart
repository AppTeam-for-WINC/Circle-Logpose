import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/user/fetch_user_profile_provider.dart';

import '../components/components/group/group_member_tile/group_member_tile.dart';

final memberSectionAdminMembersNotifierProvider =
    StateNotifierProvider<MemberSectionAdminMembersNotifier, List<Widget>>(
  MemberSectionAdminMembersNotifier.new,
);

class MemberSectionAdminMembersNotifier extends StateNotifier<List<Widget>> {
  MemberSectionAdminMembersNotifier(this.ref) : super([]){
    _loadAdminMembers();
  }

  final Ref ref;

  Future<void> _loadAdminMembers() async {
    final adminTile = ref.watch(fetchUserProfileProvider).when(
          data: (adminUserProfile) {
            if (adminUserProfile == null) {
              return const SizedBox.shrink();
            }
            return GroupMemberTile(
              memberProfile: adminUserProfile,
              adminOrMembership: 'admin',
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Text('$error'),
        );

    state = [adminTile];
  }
}
