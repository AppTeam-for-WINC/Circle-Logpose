// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_and_id_model.dart';
import '../../domain/providers/group/group/selected_group_name_provider.dart';

import '../controllers/group_and_id_list_controller.dart';
import '../notifiers/group_schedule_notifier.dart';

class GroupPickerModalHandler {
  GroupPickerModalHandler({
    required this.ref,
    required this.groupIdList,
  });

  final WidgetRef ref;
  final List<String> groupIdList;

  Future<void> handleToSelectGroup() async {
    _setGroupId();
    final groupAndIdList = await _fetchGroupAndIdList();
    await _setGroupName(groupAndIdList);
  }

  void _setGroupId() {
    final groupId = groupIdList[0];
    ref.read(groupScheduleNotifierProvider(null).notifier).setGroupId(groupId);
  }

  Future<List<GroupAndId>> _fetchGroupAndIdList() async {
    final groupAndIdListController = ref.read(groupAndIdListControllerProvider);
    return groupAndIdListController.fetchGroupAndIdList(groupIdList);
  }

  Future<void> _setGroupName(List<GroupAndId> groupAndIdList) async {
    ref.read(selectedGroupNameProvider.notifier).state =
        groupAndIdList[0].groupProfile.name;
  }
}
