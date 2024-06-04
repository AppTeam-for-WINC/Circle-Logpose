// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_setting_params_model.dart';

import '../components/common/loading_progress.dart';

import '../controllers/group/group_creation_and_update_controller.dart';

import '../navigations/to_schedule_list_and_joined_group_tab_slider.dart';

import '../notifiers/group_member_list_setter_notifier.dart';
import '../notifiers/image_path_set_notifier.dart';

import '../providers/text_field/name_field_provider.dart';

class GroupSettingSaveButtonHandler {
  GroupSettingSaveButtonHandler({
    required this.context,
    required this.ref,
    required this.groupId,
    required this.groupName,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String groupId;
  final String groupName;

  Future<void> handleSave() async {
    _updateLoadingStatus(true);
    final errorMessage = await _updateGroup();
    _updateLoadingStatus(false);

    if (errorMessage != null) {
      _displayErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<String?> _updateGroup() async {
    final groupData = GroupSettingParams(
      groupId: groupId,
      groupName: ref.read(nameFieldProvider(groupName)).text,
      image: ref.read(imagePathSetNotifierProvider),
      description: null,
      memberList: ref.read(groupMemberListSetterNotifierProvider),
    );
    final groupController = ref.read(groupCreationAndUpdateControllerProvider);

    return groupController.updateGroup(groupData);
  }

  void _updateLoadingStatus(bool loading) {
    ref.read(loadingProgressControllerProvider).loadingProgress = loading;
  }

  void _displayErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      final navigator = ToScheduleListAndJoinedGroupTabSliderNavigator(context);
      await navigator.moveToPage();
    }
  }
}
