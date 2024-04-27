import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controllers/controllers/group/create/create_group_schedule.dart';
import '../../../../../controllers/providers/error/schedule_error_msg_provider.dart';
import '../../../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';
import '../../../../../controllers/providers/group/schedule/text/schedule_detail_controller_provider.dart';
import '../../../../../controllers/providers/group/schedule/text/schedule_place_controller_provider.dart';
import '../../../../../controllers/providers/group/schedule/text/schedule_title_controller_provider.dart';

class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key, this.groupId});
  final String? groupId;
  @override
  ConsumerState createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;
    final scheduleNotifier = ref.watch(setGroupScheduleProvider(null).notifier);
    
    final schedule = ref.watch(setGroupScheduleProvider(null));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    void setGroupId() {
      if (schedule.groupId == null && groupId == null) {
        ref.watch(scheduleErrorMessageProvider.notifier).state =
            'No selected group.';
        return;
      } else if (schedule.groupId == null && groupId != null) {
        scheduleNotifier.setGroupId(groupId);
      }
    }

    Future<String?> createGroupSchedule() async {
      return CreateGroupSchedule.create(
        ref.read(setGroupScheduleProvider(null))!.groupId!,
        ref.read(scheduleTitleControllerProvider).text,
        schedule.color!,
        ref.read(schedulePlaceControllerProvider).text,
        ref.read(scheduleDetailControllerProvider).text,
        schedule.startAt,
        schedule.endAt,
      );
    }

    Future<void> save() async {
      setGroupId();
      final errorMessage = await createGroupSchedule();
      if (errorMessage != null) {
        ref.watch(scheduleErrorMessageProvider.notifier).state = errorMessage;
        return;
      }
      scheduleNotifier.initSchedule();

      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: save,
      child: const Text(
        '保存',
        style: TextStyle(
          color: CupertinoColors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
