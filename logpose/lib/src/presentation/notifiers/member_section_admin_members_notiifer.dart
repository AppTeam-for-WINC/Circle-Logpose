import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/common/group_member_tile/group_member_tile.dart';

import '../providers/user/fetch_user_profile_provider.dart';

final memberSectionAdminMembersNotifierProvider =
    StateNotifierProvider<MemberSectionAdminMembersNotifier, List<Widget>>(
  MemberSectionAdminMembersNotifier.new,
);

class MemberSectionAdminMembersNotifier extends StateNotifier<List<Widget>> {
  MemberSectionAdminMembersNotifier(this.ref) : super([]) {
    _loadAdminMembers();
  }

  final Ref ref;

  Future<void> _loadAdminMembers() async {
    try {
      final userProfile = await ref.watch(fetchUserProfileProvider.future);
      if (userProfile == null) {
        return;
      }
      final adminTile = GroupMemberTile(
        memberProfile: userProfile,
        groupRoleType: GroupRoleType.admin,
      );

      state = [adminTile];
    } on Exception catch (e) {
      state = [Text('Error: $e')];
    }
  }
}
