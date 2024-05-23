import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../handlers/color_object_handler.dart';

import '../../../schedule_color_palette.dart';

class ColorObject extends ConsumerWidget {
  const ColorObject({
    super.key,
    required this.index,
    this.groupScheduleId,
    required this.color,
  });

  final int index;
  final String? groupScheduleId;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleToTap() {
      ColorObjectHandler(
        context: context,
        ref: ref,
        scheduleColorPalette: scheduleColorPalette,
        index: index,
        groupScheduleId: groupScheduleId,
      ).handleColor();
    }

    return GestureDetector(
      onTap: handleToTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheduleColorPalette[index],
          border: color == scheduleColorPalette[index]
              ? Border.all(width: 2)
              : null,
        ),
        child: color == scheduleColorPalette[index]
            ? const Icon(
                CupertinoIcons.check_mark,
                color: CupertinoColors.white,
              )
            : null,
      ),
    );
  }
}
