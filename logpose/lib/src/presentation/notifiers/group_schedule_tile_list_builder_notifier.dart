import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../../domain/model/group_schedule_and_id_model.dart';

import '../components/components/group/group_setting/sections/schedule_section/components/components/components/group_schedule_tile/group_schedule_tile.dart';

import '../providers/group/members/listen_group_member_profile_list.dart';
import '../providers/group/schedule/listen_all_group_schedule_and_id_list_provider.dart';

final groupScheduleTileListBuilderNotifierProvider =
    StateNotifierProvider.family<_GroupScheduleTileListNotifier, List<Widget>,
        (String groupId, String groupName)>(
  (ref, args) => _GroupScheduleTileListNotifier(ref, args.$1, args.$2),
);

class _GroupScheduleTileListNotifier extends StateNotifier<List<Widget>> {
  _GroupScheduleTileListNotifier(this.ref, this.groupId, this.groupName)
      : super([]) {
    _initialize();
  }

  final Ref ref;
  final String groupId;
  final String groupName;

  Future<void> _initialize() async {
    final groupScheduleList = await ref
        .watch(listenAllGroupScheduleAndIdListProvider(groupId).future);
    final memberProfileList =
        await ref.watch(listenGroupMemberProfileListProvider(groupId).future);

    state = _buildGroupScheduleTileList(groupScheduleList, memberProfileList);
  }

  List<Widget> _buildGroupScheduleTileList(
    List<GroupScheduleAndId?> groupScheduleList,
    List<UserProfile?> memberProfiles,
  ) {
    return groupScheduleList.map((groupScheduleData) {
      if (groupScheduleData == null) {
        return const SizedBox.shrink();
      }
      return GroupScheduleTile(
        schedule: groupScheduleData,
        groupName: groupName,
        groupMemberList: memberProfiles,
      );
    }).toList();
  }
}
