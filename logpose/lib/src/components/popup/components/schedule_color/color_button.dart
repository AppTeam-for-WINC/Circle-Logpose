import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/group/schedule/set_group_schedule_provider.dart';
import 'palette_dialog.dart';

class ColorButton extends ConsumerWidget {
  const ColorButton({super.key, this.groupScheduleId});
  final String? groupScheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(setGroupScheduleProvider(groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    void showDialog() {
      showCupertinoDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return PaletteDialog(groupScheduleId: groupScheduleId);
        },
      );
    }

    return CupertinoButton(
      padding: const EdgeInsets.only(left: 20),
      onPressed: showDialog,
      child: Icon(
        CupertinoIcons.circle_fill,
        size: 50,
        color: schedule.color,
      ),
    );
  }
}
