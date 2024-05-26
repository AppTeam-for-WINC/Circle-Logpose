import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigations/pop_navigator.dart';
import '../notifiers/group_schedule_notifier.dart';

class ColorObjectHandler {
  ColorObjectHandler({
    required this.context,
    required this.ref,
    required this.scheduleColorPalette,
    required this.index,
    required this.groupScheduleId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final List<Color> scheduleColorPalette;
  final int index;
  final String? groupScheduleId;

  void handleColor() {
    _setColor();
    _moveToPage();
  }

  void _setColor() {
    ref
        .watch(groupScheduleNotifierProvider(groupScheduleId).notifier)
        .setColor(scheduleColorPalette[index]);
  }

  void _moveToPage() {
    PopNavigator(context).pop();
  }
}
