import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/providers/group/mode/schedule_delete_mode_provider.dart';

class DeleteScheduleSwitch extends ConsumerWidget {
  const DeleteScheduleSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTap() {
      ref.watch(scheduleDeleteModeProvider.notifier).state =
          !ref.watch(scheduleDeleteModeProvider);
    }

    return GestureDetector(
      onTap: onTap,
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
