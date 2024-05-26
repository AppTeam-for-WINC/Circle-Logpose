import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/dialogs/color_button_dialog_navigator.dart';

class ColorButton extends ConsumerWidget {
  const ColorButton({super.key, this.groupScheduleId, required this.color});

  final String? groupScheduleId;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (color == null) {
      return const SizedBox.shrink();
    }

    Future<void> showDialog() async {
      final navigator = ColorButtonDialogNavigator(
        context: context,
        groupScheduleId: groupScheduleId,
        color: color!,
      );

      await navigator.showDialog();
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 20),
      onPressed: showDialog,
      child: Icon(
        CupertinoIcons.circle_fill,
        size: 50,
        color: color,
      ),
    );
  }
}
