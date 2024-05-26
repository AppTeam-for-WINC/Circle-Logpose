// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/group_schedule_notifier.dart';

import '../providers/group/group/selected_group_name_provider.dart';

class GroupNameModalHandler {
  GroupNameModalHandler({
    required this.ref,
    required this.groupId,
    required this.groupName,
  });

  final WidgetRef ref;
  final String groupId;
  final String groupName;

  void handleToSelectedGroup() {
    _setGroupId();
    _setGroupName();
  }

  void _setGroupId() {
    ref.watch(groupScheduleNotifierProvider(null).notifier).setGroupId(groupId);
  }

  void _setGroupName() {
    ref.watch(selectedGroupNameProvider.notifier).state = groupName;
  }
}
