import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../handlers/schedule_addition_switch_handler.dart';

class ScheduleAdditionSwitch extends ConsumerWidget {
  const ScheduleAdditionSwitch({
    super.key,
    required this.groupId,
    this.groupName,
  });
  
  final String groupId;
  final String? groupName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleTap() async {
      final handler = ScheduleAdditionSwitchHandler(
        context,
        ref,
        groupId,
        groupName!,
      );

      await handler.handleSwitch();
    }

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFD8EB61),
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.calendar_badge_plus,
            size: 25,
            color: CupertinoColors.black,
          ),
        ),
      ),
    );
  }
}
