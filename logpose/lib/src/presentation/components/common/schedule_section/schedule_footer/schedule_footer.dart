import 'package:flutter/cupertino.dart';

import 'schedule_save_button.dart';

class ScheduleFooter extends StatelessWidget {
  const ScheduleFooter({
    super.key,
    this.defaultGroupId,
    required this.actionType,
    this.groupScheduleId,
  });

  final String? defaultGroupId;
  final ActionType actionType;
  final String? groupScheduleId;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: deviceWidth * 0.3,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF7B61FF),
        ),
        child: ScheduleSettingSaveButton(
          defaultGroupId: defaultGroupId,
          actionType: actionType,
          groupScheduleId: groupScheduleId,
        ),
      ),
    );
  }
}
