import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/user_profile.dart';

import '../../usecase/facade/user_service_facade.dart';

final fetchUserProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final userFacade = ref.read(userServiceFacadeProvider);
  final userId = await userFacade.fetchCurrentUserId();
  final userServiceFacade = ref.read(userServiceFacadeProvider);
  
  return userServiceFacade.fetchUserProfile(userId);
});
