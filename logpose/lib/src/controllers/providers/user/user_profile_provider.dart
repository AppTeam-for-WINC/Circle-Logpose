import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user/user.dart';
import '../../../services/auth/auth_controller.dart';
import '../../../services/database/user_controller.dart';

/// Used to create new group.
final readUserProfileProvider =
    FutureProvider<UserProfile>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  return UserController.read(userDocId);
});
