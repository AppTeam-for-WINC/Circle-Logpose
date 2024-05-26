import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/schedule/schedule_response.dart';

import '../../../../../../../../handlers/absence_button_handler.dart';
import '../response_button.dart';

class AbsenceButton extends ConsumerWidget {
  const AbsenceButton({
    super.key,
    required this.isAbsence,
    required this.groupScheduleId,
  });
  final bool isAbsence;
  final String groupScheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleAbsence() async {
      final handler = AbsenceButtonHandler(
        ref: ref,
        groupScheduleId: groupScheduleId,
      );
      await handler.handleAbsence();
    }

    return ResponseButton(
      isResponse: isAbsence,
      responseType: ResponseType.absence,
      groupScheduleId: groupScheduleId,
      handleResponse: handleAbsence,
    );
  }
}
