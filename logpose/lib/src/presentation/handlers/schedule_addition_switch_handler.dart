import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigations/modals/to_group_schedule_creation_navigator.dart';

import '../providers/group/group/selected_group_name_provider.dart';

class ScheduleAdditionSwitchHandler {
  const ScheduleAdditionSwitchHandler(
    this.context,
    this.ref,
    this.groupId,
    this.groupName,
  );

  final BuildContext context;
  final WidgetRef ref;
  final String groupId;
  final String groupName;

  Future<void> handleSwitch() async {
    _setGroupName();
    await _showModal();
  }

  void _setGroupName() {
    ref.watch(selectedGroupNameProvider.notifier).state = groupName;
  }

  Future<void> _showModal() async {
    if (context.mounted) {
      final navigator = ToGroupScheduleCreationNavigator(context);
      await navigator.showModal(groupId);
    }
  }
}
