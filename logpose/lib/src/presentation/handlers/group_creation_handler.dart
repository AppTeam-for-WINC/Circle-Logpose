// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/group_creator_params_model.dart';
import '../../domain/providers/text_field/name_field_provider.dart';

import '../components/common/loading_progress.dart';

import '../controllers/group_creation_controller.dart';
import '../navigations/group_creation_navigator.dart';
import '../notifiers/image_provider.dart';
import '../notifiers/set_group_member_list_notifier.dart';

class GroupCreationHandler {
  GroupCreationHandler(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handleToCreate() async {
    final groupData = GroupCreatorParams(
      groupName: ref.read(nameFieldProvider('')).text,
      image: ref.read(imageControllerProvider),
      description: null,
      memberList: ref.read(setGroupMemberListNotifierProvider),
    );

    _loadingProgress(true);
    final errorMessage = await _createGroup(groupData);
    _loadingProgress(false);

    if (errorMessage != null) {
      _displayErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  void _loadingProgress(bool loading) {
    ref.watch(loadingProgressControllerProvider).loadingProgress = loading;
  }

  Future<String?> _createGroup(GroupCreatorParams groupData) {
    final groupCreationController = ref.read(groupCreationControllerProvider);
    return groupCreationController.createGroup(groupData);
  }

  void _displayErrorMessage(String errorMessage) {
    ref.read(loadingProgressControllerProvider).loadingErrorMessage =
        errorMessage;
  }

  Future<void> _moveToPage() async {
    if (context.mounted) {
      await GroupCreationNavigator(context).moveToPage();
    }
  }
}
