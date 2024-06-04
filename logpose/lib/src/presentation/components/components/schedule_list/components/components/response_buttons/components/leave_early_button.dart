import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/schedule_response.dart';

import '../../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../../../../../handlers/leave_early_button_handler.dart';

import '../../../../../../common/response_button.dart';

class LeaveEarlyButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleLeaveEarly() async {
      final handler = LeaveEarlyButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
      );

      await handler.handleLeaveEarly();
    }

    return ResponseButton(
      isResponse: isLeaveEarly,
      responseType: ResponseType.leaveEarly,
      groupScheduleId: groupScheduleId,
      handleResponse: handleLeaveEarly,
    );
  }
}
