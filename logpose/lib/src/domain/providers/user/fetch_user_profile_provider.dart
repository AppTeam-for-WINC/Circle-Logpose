import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../usecase/facade/user_service_facade.dart';

import '../repository/auth_repository_provider.dart';

/// Fetch user profile.
final fetchUserProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userDocId = await ref.read(authRepositoryProvider).fetchCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  final userServiceFacade = ref.read(userServiceFacadeProvider);
  return userServiceFacade.fetchUserProfile(userDocId);
});
