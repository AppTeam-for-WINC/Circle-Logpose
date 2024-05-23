import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/group/group/selected_group_name_provider.dart';

import '../navigations/group_schedule_tile_navigator.dart';

class GroupScheduleTileHandler {
  GroupScheduleTileHandler({
    required this.context,
    required this.ref,
    required this.groupName,
    required this.groupScheduleId,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupName;
  final String groupScheduleId;

  Future<void> handleTile() async {
    _setGroupName();
    await _showModal();
  }

  void _setGroupName() {
     ref.watch(selectedGroupNameProvider.notifier).state = groupName;
  }

  Future<void> _showModal() async {
    final navigator = GroupScheduleTileNavigator(context, groupScheduleId);
    await navigator.showModal();
  }
}
