import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../app/facade/group_member_schedule_facade.dart';

import '../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';
import '../../../../../../../domain/model/schedule_response_params_model.dart';

import '../../../../../../../utils/schedule/schedule_response.dart';

import '../../../../../../notifiers/group_member_schedule_notifier.dart';

import '../../../../popup/behind_and_early_setting/behind_and_early_setting.dart';

class LatenessButton extends ConsumerStatefulWidget {
  const LatenessButton({
    super.key,
    required this.isLateness,
    required this.groupScheduleId,
    required this.groupProfileAndScheduleAndId,
  });
  final bool isLateness;
  final String groupScheduleId;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;

  @override
  ConsumerState<LatenessButton> createState() => _LatenessButtonState();
}

class _LatenessButtonState extends ConsumerState<LatenessButton> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final isLateness = widget.isLateness;
    final groupScheduleId = widget.groupScheduleId;
    final groupProfileAndScheduleAndId = widget.groupProfileAndScheduleAndId;

    Future<void> updateLateness({required bool lateness}) async {
      final memberScheduleNotifier = ref.watch(
        groupMemberScheduleNotifierProvider(groupScheduleId).notifier,
      );
      await memberScheduleNotifier.updateLateness(lateness: lateness);
    }

    Future<void> updateResponse({
      required String memberScheduleId,
      required bool lateness,
    }) async {
      final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
      final scheduleParams = ScheduleResponseParams(
        memberScheduleId: memberScheduleId,
        attendance: false,
        leaveEarly: false,
        lateness: !lateness,
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

      final lateness = memberScheduleController.lateness;

      await updateLateness(lateness: lateness);
      await updateResponse(
        memberScheduleId: memberScheduleController.scheduleId,
        lateness: lateness,
      );

      if (!mounted) {
        return;
      }
      // ref.read()におけるデータの変更が即座に反映されないため、再度呼び出している。
      if (ref
          .read(groupMemberScheduleNotifierProvider(groupScheduleId))!
          .lateness) {
        await showCupertinoModalPopup<BehindAndEarlySetting>(
          context: context,
          builder: (BuildContext context) {
            return BehindAndEarlySetting(
              groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
              responseIcon: ScheduleResponse.getIcon(ResponseType.lateness),
              responseText: ScheduleResponse.getText(ResponseType.lateness),
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
          color: isLateness ? const Color(0xFFFBCEFF) : CupertinoColors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScheduleResponse.getIcon(ResponseType.lateness),
              ScheduleResponse.getText(ResponseType.lateness),
            ],
          ),
        ),
      ),
    );
  }
}
