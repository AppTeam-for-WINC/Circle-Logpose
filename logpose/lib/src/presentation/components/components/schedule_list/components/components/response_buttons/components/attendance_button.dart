import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../utils/schedule_response.dart';

import '../../../../../../../handlers/attendance_button_handler.dart';

import '../../../../../../common/response_button.dart';

class AttendanceButton extends ConsumerWidget {
  const AttendanceButton({
    super.key,
    required this.isAttendance,
    required this.groupScheduleId,
  });
  final bool isAttendance;
  final String groupScheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleAttendance() async {
      final handler = AttendanceButtonHandler(
        ref: ref,
        groupScheduleId: groupScheduleId,
      );

      await handler.handleAttendance();
    }

    return ResponseButton(
      isResponse: isAttendance,
      responseType: ResponseType.attendance,
      groupScheduleId: groupScheduleId,
      handleResponse: handleAttendance,
    );
  }
}
