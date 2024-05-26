import 'package:flutter/cupertino.dart';

import '../../../navigations/dialogs/to_palette_dialog_navigator.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({super.key, this.groupScheduleId, required this.color});

  final String? groupScheduleId;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return const SizedBox.shrink();
    }

    Future<void> handleToTap() async {
      final navigator = ToPaletteDialogNavigator(context);
      await navigator.showDialog(groupScheduleId, color!);
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 20),
      onPressed: handleToTap,
      child: Icon(
        CupertinoIcons.circle_fill,
        size: 50,
        color: color,
      ),
    );
  }
}
