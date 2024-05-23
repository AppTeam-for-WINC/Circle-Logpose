import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/mode/schedule_delete_mode_provider.dart';

class ScheduleDeleteSwitchHandler {
  ScheduleDeleteSwitchHandler(this.ref);

  final WidgetRef ref;

  Future<void> handleSwitch() async {
    _switch();
  }

  void _switch() {
    ref.watch(scheduleDeleteModeProvider.notifier).state =
        !ref.read(scheduleDeleteModeProvider);
  }
}
