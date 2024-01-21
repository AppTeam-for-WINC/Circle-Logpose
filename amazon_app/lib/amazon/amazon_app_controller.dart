import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/pages/home/home_page.dart';
import 'package:amazon_app/pages/start/start_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


///Check user is logined, and select page.
Future<ConsumerWidget> firstPage() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    return const StartPage();
  }

  return const HomePage();
}
