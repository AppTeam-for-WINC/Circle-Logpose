// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_setting_params_model.dart';

import '../../domain/providers/text_field/name_field_provider.dart';

import '../components/common/loading_progress.dart';

import '../controllers/group_setting_updater_controller.dart';
import '../navigations/group_setting_save_button_navigator.dart';
import '../notifiers/image_provider.dart';
import '../notifiers/set_group_member_list_notifier.dart';

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
      image: ref.read(imageControllerProvider),
      description: null,
      memberList: ref.read(setGroupMemberListNotifierProvider),
    );
    final groupController = ref.read(groupSettingUpdaterControllerProvider);

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
      final navigator = GroupSettingSaveButtonNavigator(context);
      await navigator.moveToPage();
    }
  }
}
