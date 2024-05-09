import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/red_error_message.dart';
import '../../../controllers/providers/error/schedule_error_msg_provider.dart';
import '../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

import '../components/schedule_color/color_button.dart';
import '../components/schedule_detail/detail.dart';
import '../components/schedule_footer/schedule_footer.dart';
import '../components/schedule_group_selector/group_selector.dart';
import '../components/schedule_place/place.dart';
import '../components/schedule_time/schedule_activity_time.dart';
import '../components/schedule_title/title_field.dart';

import 'components/back_to_page_button.dart';

class ScheduleCreation extends ConsumerStatefulWidget {
  const ScheduleCreation({super.key, this.groupId});
  final String? groupId;

  @override
  ConsumerState createState() => _ScheduleCreationState();
}

class _ScheduleCreationState extends ConsumerState<ScheduleCreation> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final schedule = ref.watch(setGroupScheduleProvider(null));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);
    final groupId = widget.groupId;

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
              const ColorButton(),
              const TitleField(),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: deviceWidth * 0.1),
                      child: const Column(
                        children: [
                          GroupSelector(),
                          ScheduleActivityTime(),
                          Place(),
                          Detail(),
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
              ),
              ScheduleFooter(groupId: groupId, createOrUpdate: 'create'),
            ],
          ),
        ),
      ),
    );
  }
}
