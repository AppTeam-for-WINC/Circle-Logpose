import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../../../../../../domain/model/group_schedule_and_id_model.dart';

import '../../../../../../../../../../../utils/responsive_util.dart';
import '../../../../../../../../../../handlers/group_schedule_tile_handler.dart';

import '../../../../../../../../../../providers/group/mode/schedule_delete_mode_provider.dart';

import 'components/deletion_button/group_schedule_deletion_button.dart';
import 'components/group_schedule_tile_title_label.dart';

class GroupScheduleTile extends ConsumerStatefulWidget {
  const GroupScheduleTile({
    super.key,
    required this.schedule,
    required this.groupName,
    required this.groupMemberList,
  });
  final GroupScheduleAndId schedule;
  final String groupName;
  final List<UserProfile?> groupMemberList;

  @override
  ConsumerState<GroupScheduleTile> createState() => _GroupScheduleTileState();
}

class _GroupScheduleTileState extends ConsumerState<GroupScheduleTile> {
  Future<void> handleToTap() async {
    final handler = GroupScheduleTileHandler(
      context: context,
      ref: ref,
      groupName: widget.groupName,
      groupScheduleId: widget.schedule.groupScheduleId,
    );

    await handler.handleTile();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth);
        } else {
          return _buildDesktopLayout(deviceWidth);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.03);
  }

  Widget _buildTabletLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.025);
  }

  Widget _buildDesktopLayout(double deviceWidth) {
    return _buildLayout(deviceWidth * 0.02);
  }

  Widget _buildLayout(double titleTextSize) {
    final groupScheduleId = widget.schedule.groupScheduleId;
    final groupSchedule = widget.schedule.groupSchedule;
    final groupMemberList = widget.groupMemberList;

    return Stack(
      children: [
        GestureDetector(
          onTap: handleToTap,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 244, 219, 251),
              borderRadius: BorderRadius.circular(80),
            ),
            child: GroupScheduleTileTitleLabel(
              title: groupSchedule.title,
              titleTextSize: titleTextSize,
            ),
          ),
        ),
        if (ref.watch(scheduleDeleteModeProvider))
          Positioned(
            top: -8,
            right: 0,
            child: GroupScheduleDeletionButton(
              groupMemberList: groupMemberList,
              groupScheduleId: groupScheduleId,
            ),
          ),
      ],
    );
  }
}
