// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_and_id_model.dart';

import '../controllers/group/group_management_controller.dart';

import '../notifiers/group_schedule_notifier.dart';

import '../providers/group/group/selected_group_name_provider.dart';

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
    final groupController = ref.read(groupManagementControllerProvider);
    return groupController.fetchGroupAndIdList(groupIdList);
  }

  Future<void> _setGroupName(List<GroupAndId> groupAndIdList) async {
    ref.read(selectedGroupNameProvider.notifier).state =
        groupAndIdList[0].groupProfile.name;
  }
}
