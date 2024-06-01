import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/group_setting_schedule_section_panel_label.dart';
import 'components/group_setting_schedule_section_tile_list.dart';

class GroupSettingScheduleSectionPanel extends ConsumerStatefulWidget {
  const GroupSettingScheduleSectionPanel({
    super.key,
    required this.groupId,
    required this.groupName,
  });
  
  final String groupId;
  final String groupName;

  @override
  ConsumerState<GroupSettingScheduleSectionPanel> createState() =>
      _GroupSettingScheduleSectionPanelState();
}

class _GroupSettingScheduleSectionPanelState
    extends ConsumerState<GroupSettingScheduleSectionPanel> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: deviceWidth * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: CupertinoColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GroupSettingScheduleSectionPanelLabel(),
            GroupSettingScheduleSectionTileList(
              groupId: widget.groupId,
              groupName: widget.groupName,
            ),
          ],
        ),
      ),
    );
  }
}
