// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/user_setting_model.dart';

import '../components/common/loading_progress.dart';

import '../controllers/user/user_update_controller.dart';
import '../navigations/to_schedule_list_and_joined_group_tab_slider.dart';
import '../notifiers/image_path_set_notifier.dart';

import '../providers/text_field/name_field_provider.dart';

class UserSettingSaveButtonHandler {
  UserSettingSaveButtonHandler({
    required this.context,
    required this.ref,
    required this.name,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String name;

  Future<void> handleUpdateUserSetting() async {
    _updateLoadingStatus(true);
    final errorMessage = await _update();
    _updateLoadingStatus(false);

    if (errorMessage != null) {
      _displayErrorMessage(errorMessage);
      return;
    }

    await _moveToPage();
  }

  Future<String?> _update() async {
    final imageNotifier = ref.read(imagePathSetNotifierProvider);
    final userSettingParams = UserSettingParams(
      name: ref.watch(nameFieldProvider(name)).text,
      image: imageNotifier,
      description: null,
    );

    final userSettingController = ref.read(userUpdateControllerProvider);
    return userSettingController.updateUser(userSettingParams);
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
