import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../utils/schedule_response.dart';

import '../../../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../../../../../handlers/lateness_button_handler.dart';

import '../../../../../../common/response_button.dart';

class LatenessButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleLateness() async {
      final handler = LatenessButtonHandler(
        context: context,
        ref: ref,
        groupScheduleId: groupScheduleId,
        groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
      );

      await handler.handleLateness();
    }

    return ResponseButton(
      isResponse: isLateness,
      responseType: ResponseType.lateness,
      groupScheduleId: groupScheduleId,
      handleResponse: handleLateness,
    );
  }
}
