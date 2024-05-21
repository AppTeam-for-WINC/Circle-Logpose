import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';
import '../../../app/facade/user_service_facade.dart';

import '../../entity/user_profile.dart';

final fetchUserProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final authFacade = ref.read(authFacadeProvider);
  final userId = await authFacade.fetchCurrentUserId();
  final userServiceFacade = ref.read(userServiceFacadeProvider);
  
  return userServiceFacade.fetchUserProfile(userId);
});
