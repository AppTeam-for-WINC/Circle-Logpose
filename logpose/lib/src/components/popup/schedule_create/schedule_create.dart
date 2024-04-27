import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/error/schedule_error_msg_provider.dart';
import '../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

import 'components/back/back_to_page_button.dart';
import 'components/color/color_button.dart';
import 'components/detail/detail.dart';
import 'components/error/schedule_error.dart';
import 'components/footer/footer.dart';
import 'components/group/group_selector.dart';
import 'components/place/place.dart';
import 'components/time/schedule_activity_time.dart';
import 'components/title/title_field.dart';

class ScheduleCreate extends ConsumerStatefulWidget {
  const ScheduleCreate({super.key, this.groupId});

  final String? groupId;
  @override
  ConsumerState createState() => _ScheduleCreateState();
}

class _ScheduleCreateState extends ConsumerState<ScheduleCreate> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final groupId = widget.groupId;
    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);
    
    final schedule = ref.watch(setGroupScheduleProvider(null));
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
                      ScheduleError(errorMessage: scheduleErrorMessage),
                  ],
                ),
              ),
              ScheduleFooter(groupId: groupId),
            ],
          ),
        ),
      ),
    );
  }
}
