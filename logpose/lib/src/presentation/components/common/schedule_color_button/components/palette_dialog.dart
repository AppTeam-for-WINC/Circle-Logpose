import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../schedule_color_palette.dart';

import 'components/color_object.dart';

class PaletteDialog extends ConsumerWidget {
  const PaletteDialog({super.key, this.groupScheduleId, required this.color});

  final String? groupScheduleId;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      content: SizedBox(
        height: 110,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemCount: scheduleColorPalette.length,
          itemBuilder: (BuildContext context, int index) {
            return ColorObject(
              index: index,
              groupScheduleId: groupScheduleId,
              color: color,
            );
          },
        ),
      ),
    );
  }
}
