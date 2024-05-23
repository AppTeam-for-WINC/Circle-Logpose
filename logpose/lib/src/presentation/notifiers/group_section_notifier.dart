import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/group/listen_joined_group_profile_provider.dart';
import '../components/components/user_setting/sections/group_section/user_joined_group_tile.dart';

final joinedGroupListNotifierProvider =
    StateNotifierProvider<JoinedGroupListNotifier, List<Widget>>(
  JoinedGroupListNotifier.new,
);

class JoinedGroupListNotifier extends StateNotifier<List<Widget>> {
  JoinedGroupListNotifier(this.ref) : super([]) {
    _fetchGroupProfiles();
  }

  final Ref ref;

  Future<void> _fetchGroupProfiles() async {
    final groupsProfile =
        await ref.watch(listenJoinedGroupIdListProvider.future);
    state = _buildUserJoinedGroupTileList(groupsProfile);
  }

  List<Widget> _buildUserJoinedGroupTileList(List<String> groupProfiles) {
    return groupProfiles.map((groupId) {
      return UserJoinedGroupTile(groupId: groupId);
    }).toList();
  }
}
