import 'package:flutter/material.dart';

import '../database/auth/auth_controller.dart';
import '../pages/src/home/home_page.dart';
import '../pages/src/start/start_page.dart';

/// Check user is logined, and select page.
Future<Widget> firstPage() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    return const StartPage();
  }
  return const HomePage();
}
