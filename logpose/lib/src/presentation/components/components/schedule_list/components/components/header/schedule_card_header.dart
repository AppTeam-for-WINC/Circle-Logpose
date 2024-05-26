import 'package:flutter/cupertino.dart';

import '../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../domain/entity/group_schedule.dart';

import 'components/schdule_card_time_view.dart';
import 'components/schedule_detail_confirmation_button.dart';

class ScheduleCardHeader extends StatelessWidget {
  const ScheduleCardHeader({
    super.key,
    required this.groupSchedule,
    required this.groupScheduleId,
    required this.groupProfile,
  });

  final GroupSchedule groupSchedule;
  final String groupScheduleId;
  final GroupProfile groupProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 10),
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScheduleCardTimeView(groupSchedule: groupSchedule),
          ScheduleDetailConfirmationButton(
            groupScheduleId: groupScheduleId,
            groupProfile: groupProfile,
            groupSchedule: groupSchedule,
          ),
        ],
      ),
    );
  }
}
