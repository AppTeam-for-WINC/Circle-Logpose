import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../usecase/user_use_case.dart';
import '../auth/auth_controller_provider.dart';

/// Fetch user profile.
final fetchUserProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userDocId = await ref.read(authRepositoryProvider).fetchCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  final userRepository = ref.read(userUseCaseProvider);
  return userRepository.fetchUserProfile(userDocId);
});
