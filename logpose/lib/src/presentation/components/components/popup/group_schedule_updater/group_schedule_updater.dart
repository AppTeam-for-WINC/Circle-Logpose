import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../notifiers/group_schedule_notifier.dart';

import '../../../../providers/error_message/schedule_error_msg_provider.dart';

import '../../../common/back_to_page_button.dart';
import '../../../common/schedule_color_button/color_button.dart';
import '../../../common/schedule_section/schedule_field/title_text_field.dart';
import '../../../common/schedule_section/schedule_footer/schedule_footer.dart';
import '../../../common/schedule_section/schedule_footer/schedule_save_button.dart';

import 'components/group_schedule_updater_container.dart';

class GroupScheduleUpdater extends ConsumerStatefulWidget {
  const GroupScheduleUpdater({super.key, required this.groupScheduleId});

  final String groupScheduleId;

  @override
  ConsumerState createState() => _GroupScheduleUpdaterState();
}

class _GroupScheduleUpdaterState extends ConsumerState<GroupScheduleUpdater> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupScheduleId = widget.groupScheduleId;
    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);

    final schedule = ref.watch(groupScheduleNotifierProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          color: CupertinoColors.white,
          width: deviceWidth * 0.88,
          height: deviceHeight * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackToPageButton(iconColor: Color(0xFF7B61FF),),
              ColorButton(
                groupScheduleId: groupScheduleId,
                color: schedule.color,
              ),
              const TitleTextField(),
              GroupScheduleUpdaterContainer(
                groupScheduleId: groupScheduleId,
                scheduleErrorMessage: scheduleErrorMessage,
              ),
              ScheduleFooter(
                defaultGroupId: schedule.groupId,
                actionType: ActionType.update,
                groupScheduleId: groupScheduleId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
