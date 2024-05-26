import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/entity/group_profile.dart';
import '../../../../../../../../domain/entity/group_schedule.dart';

import '../../../../../../../navigations/modals/to_schedule_detail_confirm_navigator.dart';

class ScheduleDetailConfirmationButton extends ConsumerWidget {
  const ScheduleDetailConfirmationButton({
    super.key,
    required this.groupScheduleId,
    required this.groupProfile,
    required this.groupSchedule,
  });

  final String groupScheduleId;
  final GroupProfile groupProfile;
  final GroupSchedule groupSchedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Future<void> handleToTap() async {
      final navigator =
          ToScheduleDetailConfirmNavigator(context: context, ref: ref);
      await navigator.showModal(
        groupScheduleId: groupScheduleId,
        groupProfile: groupProfile,
        groupSchedule: groupSchedule,
      );
    }

    return GestureDetector(
      onTap: handleToTap,
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: deviceWidth * 0.35),
            child: Text(
              groupSchedule.title,
              textAlign: TextAlign.end,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 20,
            color: Color(0xFF7B61FF),
          ),
        ],
      ),
    );
  }
}
