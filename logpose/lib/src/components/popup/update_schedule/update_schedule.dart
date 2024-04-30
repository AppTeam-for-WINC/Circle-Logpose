import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/error/schedule_error_msg_provider.dart';
import '../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

import '../../back_to_page_button/back_to_page_button.dart';
import '../components/schedule_color/color_button.dart';
import '../components/schedule_detail/detail.dart';
import '../components/schedule_error/schedule_error.dart';
import '../components/schedule_footer/schedule_footer.dart';
import '../components/schedule_group_selector/group_selector.dart';
import '../components/schedule_place/place.dart';
import '../components/schedule_time/schedule_activity_time.dart';
import '../components/schedule_title/title_field.dart';

class UpdateSchedule extends ConsumerStatefulWidget {
  const UpdateSchedule({super.key, required this.groupScheduleId});

  final String groupScheduleId;
  @override
  ConsumerState createState() => _UpdateScheduleState();
}

class _UpdateScheduleState extends ConsumerState<UpdateSchedule> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupScheduleId = widget.groupScheduleId;
    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);

    final schedule = ref.watch(setGroupScheduleProvider(groupScheduleId));
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
              const BackToPageButton(),
              ColorButton(groupScheduleId: groupScheduleId),
              const TitleField(),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: deviceWidth * 0.1),
                      child: Column(
                        children: [
                          const GroupSelector(),
                          ScheduleActivityTime(
                            groupScheduleId: groupScheduleId,
                          ),
                          const Place(),
                          const Detail(),
                        ],
                      ),
                    ),
                    if (scheduleErrorMessage != null)
                      ScheduleError(errorMessage: scheduleErrorMessage),
                  ],
                ),
              ),
              ScheduleFooter(
                groupId: schedule.groupId,
                createOrUpdate: 'update',
                groupScheduleId: groupScheduleId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
