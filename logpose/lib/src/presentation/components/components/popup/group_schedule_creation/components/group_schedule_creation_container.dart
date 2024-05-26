import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/red_error_message.dart';

import '../../../../common/schedule_section/detail_section.dart';
import '../../../../common/schedule_section/place_section.dart';
import '../../../../common/schedule_section/schedule_group_selector/group_selector.dart';
import '../../../../common/schedule_section/schedule_time/schedule_activity_time.dart';

class GroupScheduleCreationContainer extends ConsumerStatefulWidget {
  const GroupScheduleCreationContainer({super.key, this.scheduleErrorMessage});

  final String? scheduleErrorMessage;

  @override
  ConsumerState createState() => _GroupScheduleCreationContainerState();
}

class _GroupScheduleCreationContainerState
    extends ConsumerState<GroupScheduleCreationContainer> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final scheduleErrorMessage = widget.scheduleErrorMessage;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: deviceWidth * 0.1),
            child: const Column(
              children: [
                GroupSelector(),
                ScheduleActivityTime(),
                PlaceSection(),
                DetailSection(),
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
