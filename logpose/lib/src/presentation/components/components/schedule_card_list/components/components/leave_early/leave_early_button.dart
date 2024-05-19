import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../../../../../../../domain/model/schedule_response_params_model.dart';

import '../../../../../../../domain/usecase/facade/group_member_schedule_facade.dart';

import '../../../../../../../utils/schedule/schedule_response.dart';

import '../../../../../../notifiers/group_member_schedule_notifier.dart';

import '../../../../popup/behind_and_early_setting/behind_and_early_setting.dart';

class LeaveEarlyButton extends ConsumerStatefulWidget {
  const LeaveEarlyButton({
    super.key,
    required this.isLeaveEarly,
    required this.groupScheduleId,
    required this.groupProfileAndScheduleAndId,
  });
  final bool isLeaveEarly;
  final String groupScheduleId;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;

  @override
  ConsumerState<LeaveEarlyButton> createState() => _LeaveEarlyButtonState();
}

class _LeaveEarlyButtonState extends ConsumerState<LeaveEarlyButton> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final isLeaveEarly = widget.isLeaveEarly;
    final groupScheduleId = widget.groupScheduleId;
    final groupProfileAndScheduleAndId = widget.groupProfileAndScheduleAndId;

    Future<void> updateLeaveEarly({required bool leaveEarly}) async {
      final memberScheduleNotifier = ref.watch(
        groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
      );
      await memberScheduleNotifier.updateLeaveEarly(leaveEarly: leaveEarly);
    }

    Future<void> updateResponse({
      required String memberScheduleId,
      required bool leaveEarly,
    }) async {
      final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
      final scheduleParams = ScheduleResponseParams(
        memberScheduleId: memberScheduleId,
        attendance: false,
        leaveEarly: !leaveEarly,
        lateness: false,
        absence: false,
      );
      await memberScheduleFacade.updateResponse(scheduleParams);
    }

    Future<void> onTap() async {
      final memberScheduleController =
          ref.read(groupMemberScheduleNotifierProvider(groupScheduleId));
      if (memberScheduleController == null) {
        return;
      }

      final leaveEarly = memberScheduleController.leaveEarly;

      await updateLeaveEarly(leaveEarly: leaveEarly);
      await updateResponse(
        memberScheduleId: memberScheduleController.scheduleId,
        leaveEarly: leaveEarly,
      );

      if (!mounted) {
        return;
      }
      // ref.read()におけるデータの変更が即座に反映されないため、再度呼び出している。
      if (ref
          .read(groupMemberScheduleNotifierProvider(groupScheduleId))!
          .leaveEarly) {
        await showCupertinoModalPopup<BehindAndEarlySetting>(
          context: context,
          builder: (BuildContext context) {
            return BehindAndEarlySetting(
              groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
              responseIcon: ScheduleResponse.getIcon(ResponseType.leaveEarly),
              responseText: ScheduleResponse.getText(ResponseType.leaveEarly),
            );
          },
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: deviceWidth * 0.185,
        height: deviceHeight * 0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: isLeaveEarly ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(ResponseType.leaveEarly),
              ScheduleResponse.getText(ResponseType.leaveEarly),
            ],
          ),
        ),
      ),
    );
  }
}
