import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/group_schedule_tile_list_builder.dart';

class GroupSettingScheduleSectionTileList extends ConsumerStatefulWidget {
  const GroupSettingScheduleSectionTileList({
    super.key,
    required this.groupId,
    required this.groupName,
  });
  final String groupId;
  final String groupName;

  @override
  ConsumerState<GroupSettingScheduleSectionTileList> createState() =>
      _GroupSettingScheduleSectionTileListState();
}

class _GroupSettingScheduleSectionTileListState
    extends ConsumerState<GroupSettingScheduleSectionTileList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupId = widget.groupId;

    return SingleChildScrollView(
      child: Container(
        width: deviceWidth * 0.7,
        height: deviceHeight * 0.3,
        padding: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
        child: GroupScheduleTileListBuilder(
          groupId: groupId,
          groupName: widget.groupName,
        ),
      ),
    );
  }
}
