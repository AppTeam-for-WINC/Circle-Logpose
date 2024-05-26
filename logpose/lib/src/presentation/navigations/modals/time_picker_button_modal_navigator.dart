import 'package:flutter/cupertino.dart';

import '../../components/components/popup/behind_and_early_setting/components/components/components/date_picker_setting_dialog.dart';

class TimePickerButtonModalNavigator {
  TimePickerButtonModalNavigator({
    required this.context,
    required this.groupScheduleId,
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
    required this.updateJoinTime,
    required this.setJoinTime,
  });

  final BuildContext context;
  final DateTime initialDateTime;
  final String groupScheduleId;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final Future<void> Function() updateJoinTime;
  final Future<void> Function(DateTime newTime) setJoinTime;

  Future<void> showModal() async {
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
