import 'package:flutter/cupertino.dart';

import '../../components/common/schedule_color_button/components/palette_dialog.dart';

class ToPaletteDialogNavigator {
  ToPaletteDialogNavigator(this.context);

  final BuildContext context;

  Future<void> showDialog(String? groupScheduleId, Color color) async {
    await showCupertinoDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return PaletteDialog(groupScheduleId: groupScheduleId, color: color);
      },
    );
  }
}
