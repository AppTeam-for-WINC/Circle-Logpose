import 'package:flutter/cupertino.dart';

import '../../components/components/popup/behind_and_early_setting/components/components/components/date_picker_setting_dialog.dart';

class ToDatePickerSettingDialogNavigator {
  ToDatePickerSettingDialogNavigator(this.context);

  final BuildContext context;

  Future<void> showModal({
    required String groupScheduleId,
    required DateTime initialDateTime,
    required DateTime minimumDate,
    required DateTime maximumDate,
    required Future<void> Function() updateJoinTime,
    required Future<void> Function(DateTime newTime) setJoinTime,
  }) async {
    await showCupertinoModalPopup<DatePickerSettingDialog>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerSettingDialog(
          groupScheduleId: groupScheduleId,
          initialDateTime: initialDateTime,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          updateJoinTime: updateJoinTime,
          setJoinTime: setJoinTime,
        );
      },
    );
  }
}
