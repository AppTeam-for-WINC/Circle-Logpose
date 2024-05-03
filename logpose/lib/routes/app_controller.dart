import 'package:flutter/material.dart';

import '../src/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../src/services/auth/auth_controller.dart';
import '../src/views/start/start_page.dart';

/// Check user is logined, and select page.
Future<Widget> firstPage() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    return const StartPage();
  }
  return const ScheduleListAndJoinedGroupTabSlider();
}
