import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/group_setting_schedule_section_panel.dart';
import 'components/switch/schedule_addition_switch.dart';
import 'components/switch/schedule_delete_switch.dart';

class GroupSettingScheduleSection extends ConsumerStatefulWidget {
  const GroupSettingScheduleSection({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  ConsumerState createState() => _GroupSettingScheduleSectionState();
}

class _GroupSettingScheduleSectionState
    extends ConsumerState<GroupSettingScheduleSection> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupId = widget.groupId;
    final groupName = widget.groupName;

    return SizedBox(
      width: deviceWidth * 0.89,
      height: deviceHeight * 0.36,
      child: Stack(
        children: [
          GroupSettingScheduleSectionPanel(
            groupId: groupId,
            groupName: groupName,
          ),
          Positioned(
            top: 10,
            right: 0,
            child: ScheduleAdditionSwitch(
              groupId: groupId,
              groupName: groupName,
            ),
          ),
          const Positioned(
            top: 60,
            right: 0,
            child: ScheduleDeleteSwitch(),
          ),
        ],
      ),
    );
  }
}
