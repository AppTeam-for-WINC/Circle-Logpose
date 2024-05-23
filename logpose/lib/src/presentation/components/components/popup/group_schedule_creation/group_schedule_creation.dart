import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../domain/providers/error_message/schedule_error_msg_provider.dart';
import '../../../../notifiers/group_schedule_notifier.dart';

import '../../../common/back_to_page_button.dart';
import '../../../common/schedule_color_button/color_button.dart';

import '../components/schedule_footer/schedule_footer.dart';
import '../components/schedule_title/title_field.dart';
import 'components/group_schedule_creation_container.dart';

class GroupScheduleCreation extends ConsumerStatefulWidget {
  const GroupScheduleCreation({super.key, this.groupId});

  final String? groupId;
  @override
  ConsumerState createState() => _GroupScheduleCreationState();
}

class _GroupScheduleCreationState extends ConsumerState<GroupScheduleCreation> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final scheduleErrorMessage = ref.watch(scheduleErrorMessageProvider);

    final schedule = ref.watch(groupScheduleNotifierProvider(null));
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
              ColorButton(color: schedule.color!),
              const TitleField(),
              GroupScheduleCreationContainer(
                scheduleErrorMessage: scheduleErrorMessage,
              ),
              ScheduleFooter(groupId: widget.groupId, createOrUpdate: 'create'),
            ],
          ),
        ),
      ),
    );
  }
}
