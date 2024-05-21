import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/app/facade/auth_facade.dart';

import '../src/presentation/components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../src/presentation/pages/start/start_page.dart';

Future<Widget> firstPage(WidgetRef ref) async {
  final authFacade = ref.read(authFacadeProvider);
  final userId = await authFacade.fetchCurrentUserIdNullable();

  if (userId == null) {
    return const StartPage();
  }
  return const ScheduleListAndJoinedGroupTabSlider();
}
