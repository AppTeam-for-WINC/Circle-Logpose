import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/presentation/components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../src/presentation/controllers/auth/auth_management_controller.dart';
import '../src/presentation/pages/start/start_page.dart';

Future<Widget> firstPage(WidgetRef ref) async {
  final authController = ref.read(authManagementControllerProvider);
  final userId = await authController.fetchCurrentUserIdNullable();

  if (userId == null) {
    return const StartPage();
  }
  return const ScheduleListAndJoinedGroupTabSlider();
}
