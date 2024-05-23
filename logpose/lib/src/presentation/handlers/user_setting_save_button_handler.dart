// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/user_setting_model.dart';
import '../../domain/providers/text_field/name_field_provider.dart';

import '../components/common/loading_progress.dart';

import '../controllers/user_setting_updater_controller.dart';
import '../navigations/user_setting_save_button_navigator.dart';
import '../notifiers/image_provider.dart';

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

    if (context.mounted) {
      await _moveToPage();
    }
  }

  Future<String?> _update() async {
    final imageNotifier = ref.read(imageControllerProvider);
    final userSettingParams = UserSettingParams(
      name: ref.watch(nameFieldProvider(name)).text,
      image: imageNotifier,
      description: null,
    );

    final userSettingController = ref.read(userSettingUpdaterController);
    return userSettingController.update(userSettingParams);
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
      final navigator = UserSettingSaveButtonNavigator(context);
      await navigator.moveToPage();
    }
  }
}
