import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/red_error_message.dart';

import '../../components/schedule_detail/detail.dart';
import '../../components/schedule_group_selector/group_selector.dart';
import '../../components/schedule_place/place.dart';
import '../../components/schedule_time/schedule_activity_time.dart';

class GroupScheduleUpdaterContainer extends ConsumerStatefulWidget {
  const GroupScheduleUpdaterContainer({
    super.key,
    required this.groupScheduleId,
    required this.scheduleErrorMessage,
  });

  final String groupScheduleId;
  final String? scheduleErrorMessage;

  @override
  ConsumerState createState() => _GroupScheduleUpdaterContainerState();
}

class _GroupScheduleUpdaterContainerState
    extends ConsumerState<GroupScheduleUpdaterContainer> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final groupScheduleId = widget.groupScheduleId;
    final scheduleErrorMessage = widget.scheduleErrorMessage;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: deviceWidth * 0.1),
            child: Column(
              children: [
                const GroupSelector(),
                ScheduleActivityTime(groupScheduleId: groupScheduleId),
                const Place(),
                const Detail(),
              ],
            ),
          ),
          if (scheduleErrorMessage != null)
            RedErrorMessage(
              errorMessage: scheduleErrorMessage,
              fontSize: 14,
            ),
        ],
      ),
    );
  }
}
