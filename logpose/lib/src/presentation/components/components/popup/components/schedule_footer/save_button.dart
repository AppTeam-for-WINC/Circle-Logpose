import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../domain/model/schedule_params_model.dart';

import '../../../../../../domain/providers/error_message/schedule_error_msg_provider.dart';
import '../../../../../../domain/providers/text_field/schedule_detail_controller_provider.dart';
import '../../../../../../domain/providers/text_field/schedule_place_controller_provider.dart';
import '../../../../../../domain/providers/text_field/schedule_title_controller_provider.dart';

import '../../../../../../domain/usecase/facade/group_schedule_facade.dart';

import '../../../../../notifiers/group_schedule_notifier.dart';

/// createOrUpdate is 'create' or 'update'.
class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({
    super.key,
    this.groupId,
    this.groupScheduleId,
    required this.createOrUpdate,
  });
  final String? groupId;
  final String createOrUpdate;
  final String? groupScheduleId;
  @override
  ConsumerState createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  @override
  Widget build(BuildContext context) {
    final groupId = widget.groupId;
    final groupScheduleId = widget.groupScheduleId;
    final scheduleNotifier =
        ref.watch(groupScheduleNotifierProvider(groupScheduleId).notifier);

    final schedule = ref.watch(
      groupScheduleNotifierProvider(groupScheduleId),
    );
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
      if (ref.read(groupScheduleNotifierProvider(null))!.groupId == null) {
        return 'No selected group.';
      }

      final scheduleFacade = ref.read(groupScheduleFacadeProvider);
      return scheduleFacade.createSchedule(
        ScheduleParams(
          groupId: ref.read(groupScheduleNotifierProvider(null))!.groupId!,
          title: ref.read(scheduleTitleControllerProvider).text,
          color: schedule.color!,
          place: ref.read(schedulePlaceControllerProvider).text,
          detail: ref.read(scheduleDetailControllerProvider).text,
          startAt: schedule.startAt,
          endAt: schedule.endAt,
        ),
      );
    }

    Future<String?> updateGroupSchedule() async {
      if (groupScheduleId == null) {
        throw Exception('GroupSchedule ID is null.');
      }
      final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
      return groupScheduleFacade.update(
        groupScheduleId,
        ScheduleParams(
          groupId: schedule.groupId!,
          title: ref.read(scheduleTitleControllerProvider).text,
          color: schedule.color!,
          place: ref.read(schedulePlaceControllerProvider).text,
          detail: ref.read(scheduleDetailControllerProvider).text,
          startAt: schedule.startAt,
          endAt: schedule.endAt,
        ),
      );
    }

    Future<String?> createOrUpdateSchedule() async {
      if (widget.createOrUpdate == 'create') {
        return createGroupSchedule();
      } else if (widget.createOrUpdate == 'update') {
        return updateGroupSchedule();
      } else {
        throw Exception('Error: set another mode.');
      }
    }

    void pop() {
      Navigator.of(context).pop();
    }

    Future<void> save() async {
      setGroupId();
      final errorMessage = await createOrUpdateSchedule();
      if (errorMessage != null) {
        ref.watch(scheduleErrorMessageProvider.notifier).state = errorMessage;
        return;
      }

      if (!mounted) {
        return;
      }
      pop();
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: save,
      child: const Text(
        '保存',
        style: TextStyle(color: CupertinoColors.white, fontSize: 16),
      ),
    );
  }
}
