import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/group/selected_group_name_provider.dart';
import '../navigations/schedule_addition_switch_modal_navigator.dart';

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
    final navigator =
        ScheduleAdditionSwitchModalNavigator(context, ref, groupId);
    await navigator.showModal();
  }
}
