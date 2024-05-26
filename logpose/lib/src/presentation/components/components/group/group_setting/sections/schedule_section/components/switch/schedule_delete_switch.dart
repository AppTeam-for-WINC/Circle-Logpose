import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../handlers/schedule_delete_switch_handler.dart';

class ScheduleDeleteSwitch extends ConsumerWidget {
  const ScheduleDeleteSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleTap() async {
      final handler = ScheduleDeleteSwitchHandler(ref);
      await handler.handleSwitch();
    }

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFEB6161),
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.calendar_badge_minus,
            size: 25,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
