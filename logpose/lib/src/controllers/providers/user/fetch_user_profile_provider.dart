import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';
import '../../../services/auth/auth_controller.dart';
import '../../../services/database/user_controller.dart';

/// Fetch user profile.
final fetchUserProfileProvider =
    FutureProvider<UserProfile>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  return UserController.read(userDocId);
});
