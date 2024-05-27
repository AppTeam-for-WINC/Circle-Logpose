import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

import '../controllers/auth/auth_management_controller.dart';

import '../pages/start/start_page.dart';

class AppHandler {
  AppHandler(this.ref);

  final WidgetRef ref;

  Future<Widget> showFirstPage() async {
    final authController = ref.read(authManagementControllerProvider);
    final userId = await authController.fetchCurrentUserIdNullable();

    if (userId == null) {
      return const StartPage();
    }
    return const ScheduleListAndJoinedGroupTabSlider();
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200), () {});
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}
