import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';
import '../../domain/providers/user/fetch_user_profile_provider.dart';
import '../components/common/group_member_tile/group_member_tile.dart';

final adminMemberTileNotifierNotifierProvider =
    StateNotifierProvider<_AdminMemberTileNotifier, Widget>(
  _AdminMemberTileNotifier.new,
);

class _AdminMemberTileNotifier extends StateNotifier<Widget> {
  _AdminMemberTileNotifier(this.ref) : super(const SizedBox.shrink()) {
    _fetchUserProfile();
  }

  final Ref ref;

  Future<void> _fetchUserProfile() async {
    final userProfile = await ref.watch(fetchUserProfileProvider.future);
    if (userProfile != null) {
      state = _buildMemberTile(userProfile);
    }
  }

  Widget _buildMemberTile(UserProfile userProfile) {
    return GroupMemberTile(
      memberProfile: userProfile,
      groupRoleType: GroupRoleType.admin,
    );
  }
}
