import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/user_profile.dart';

import '../../controllers/auth/auth_management_controller.dart';
import '../../controllers/user/user_management_controller.dart';

final fetchUserProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final authController = ref.read(authManagementControllerProvider);
  final userId = await authController.fetchCurrentUserId();
  final userManagementController = ref.read(userManagementControllerProvider);
  
  return userManagementController.fetchUserProfile(userId);
});
