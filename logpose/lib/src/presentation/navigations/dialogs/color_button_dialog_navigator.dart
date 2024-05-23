import 'package:flutter/cupertino.dart';

import '../../components/common/schedule_color_button/components/palette_dialog.dart';

class ColorButtonDialogNavigator {
  ColorButtonDialogNavigator({
    required this.context,
    required this.groupScheduleId,
    required this.color,
  });

  final BuildContext context;
  final String? groupScheduleId;
  final Color color;

  Future<void> showDialog() async {
    await showCupertinoDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return PaletteDialog(groupScheduleId: groupScheduleId, color: color);
      },
    );
  }
}
