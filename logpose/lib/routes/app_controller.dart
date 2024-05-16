import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

import '../src/domain/usecase/auth_use_case.dart';

import '../src/views/start/start_page.dart';

/// Check user is logined, and select page.
Future<Widget> firstPage(WidgetRef ref) async {
  final authuserCase = ref.read(authUseCaseProvider);
  final userId = await authuserCase.fetchCurrentUserIdNullable();

  if (userId == null) {
    return const StartPage();
  }
  return const ScheduleListAndJoinedGroupTabSlider();
}
