

import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/user/user_controller.dart';

Future<String> getAccountId() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    throw Exception('Error: No userId');
  }
  final userProfile = await UserController.read(userId);
  return userProfile.accountId;
}
