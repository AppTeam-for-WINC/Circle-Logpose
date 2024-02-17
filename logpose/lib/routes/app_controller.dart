import 'package:flutter/material.dart';

import '../src/services/auth/auth_controller.dart';
import '../src/views/src/home/home_page.dart';
import '../src/views/src/start/start_page.dart';

/// Check user is logined, and select page.
Future<Widget> firstPage() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    return const StartPage();
  }
  return const HomePage();
}
