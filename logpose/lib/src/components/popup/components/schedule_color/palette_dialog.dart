import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/schedule_color_palette.dart';
import '../../../../controllers/providers/group/schedule/set_group_schedule_provider.dart';

class PaletteDialog extends ConsumerWidget {
  const PaletteDialog({super.key, this.groupScheduleId});

  final String? groupScheduleId;

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
            return _ColorObject(index: index, groupScheduleId: groupScheduleId);
          },
        ),
      ),
    );
  }
}

class _ColorObject extends ConsumerWidget {
  const _ColorObject({required this.index, this.groupScheduleId});
  final int index;
  final String? groupScheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleNotifier =
        ref.watch(setGroupScheduleProvider(groupScheduleId).notifier);

    final schedule = ref.watch(setGroupScheduleProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    void onTap(int index) {
      scheduleNotifier.setColor(
        scheduleColorPalette[index],
      );
      Navigator.of(context).pop();
    }

    return GestureDetector(
      onTap: () => onTap(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheduleColorPalette[index],
          border: schedule.color == scheduleColorPalette[index]
              ? Border.all(width: 2)
              : null,
        ),
        child: schedule.color == scheduleColorPalette[index]
            ? const Icon(
                CupertinoIcons.check_mark,
                color: CupertinoColors.white,
              )
            : null,
      ),
    );
  }
}
