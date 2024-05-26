import 'package:flutter/cupertino.dart';

import '../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../utils/schedule/schedule_response.dart';

import '../../components/components/popup/behind_and_early_setting/behind_and_early_setting.dart';

class ToBehindAndEarlySettingNavigator {
  ToBehindAndEarlySettingNavigator(this.context);

  final BuildContext context;

  Future<void> showModal({
    required bool response,
    required String groupScheduleId,
    required GroupProfileAndScheduleAndId groupProfileAndScheduleAndId,
    required ResponseType responseType,
  }) async {
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
