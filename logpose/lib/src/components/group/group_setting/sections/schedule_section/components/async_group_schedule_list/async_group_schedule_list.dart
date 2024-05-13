import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../controllers/providers/group/members/watch_group_member_profile_list.dart';
import '../../../../../../../controllers/providers/group/schedule/watch_group_schedule_and_id_provider.dart';

import '../../../../../../../models/custom/group_schedule_and_id_model.dart';
import '../../../../../group_schedule_tile/group_schedule_tile.dart';

class AsyncGroupScheduleList extends ConsumerStatefulWidget {
  const AsyncGroupScheduleList({
    super.key,
    required this.groupId,
    required this.groupName,
  });
  final String groupId;
  final String groupName;

  @override
  ConsumerState<AsyncGroupScheduleList> createState() =>
      _AsyncGroupScheduleListState();
}

class _AsyncGroupScheduleListState
    extends ConsumerState<AsyncGroupScheduleList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupId = widget.groupId;
    final asyncGroupScheduleList =
        ref.watch(watchGroupScheduleAndIdProvider(groupId));
    final asyncGroupMemberProfileList =
        ref.watch(watchGroupMemberProfileListProvider(groupId));

    Widget asyncGroupScheduleTile(GroupScheduleAndId groupScheduleData) {
      return asyncGroupMemberProfileList.when(
        data: (memberProfiles) {
          return GroupScheduleTile(
            schedule: groupScheduleData,
            groupName: widget.groupName,
            groupMemberList: memberProfiles,
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => Text('$error'),
      );
    }

    List<Widget> groupScheduleTileList(
      List<GroupScheduleAndId?> groupScheduleList,
    ) {
      return groupScheduleList.map((groupScheduleData) {
        if (groupScheduleData == null) {
          return const SizedBox.shrink();
        }

        return asyncGroupScheduleTile(groupScheduleData);
      }).toList();
    }

    List<Widget> asyncGroupScheduleTileList() {
      return asyncGroupScheduleList.when(
        data: (groupScheduleList) {
          if (groupScheduleList.isEmpty) {
            return [const SizedBox.shrink()];
          }
          return groupScheduleTileList(groupScheduleList);
        },
        loading: () => [const SizedBox.shrink()],
        error: (error, stack) => [Text('$error')],
      );
    }

    return SingleChildScrollView(
      child: Container(
        width: deviceWidth * 0.7,
        height: deviceHeight * 0.3,
        padding: const EdgeInsets.only(
          right: 5,
          left: 5,
          bottom: 5,
        ),
        child: GridView.count(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: 6,
          mainAxisSpacing: 12,
          children: asyncGroupScheduleTileList(),
        ),
      ),
    );
  }
}
