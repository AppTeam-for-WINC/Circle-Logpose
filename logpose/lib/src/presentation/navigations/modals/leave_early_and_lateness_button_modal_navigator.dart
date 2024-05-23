import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../utils/schedule/schedule_response.dart';

import '../../components/components/popup/behind_and_early_setting/behind_and_early_setting.dart';

class LeaveEalryAndLatenessButtonModalNavigator {
  LeaveEalryAndLatenessButtonModalNavigator({
    required this.context,
    required this.ref,
    required this.groupScheduleId,
    required this.response,
    required this.groupProfileAndScheduleAndId,
    required this.responseType,
  });

  final BuildContext context;
  final WidgetRef ref;
  final bool response;
  final String groupScheduleId;
  final GroupProfileAndScheduleAndId groupProfileAndScheduleAndId;
  final ResponseType responseType;

  Future<void> showModal() async {
    if (!context.mounted) {
      return;
    }

    if (response) {
      await showCupertinoModalPopup<BehindAndEarlySetting>(
        context: context,
        builder: (BuildContext context) {
          return BehindAndEarlySetting(
            groupProfileAndScheduleAndId: groupProfileAndScheduleAndId,
            responseIcon: ScheduleResponse.getIcon(responseType),
            responseText: ScheduleResponse.getText(responseType),
          );
        },
      );
    }
  }
}
