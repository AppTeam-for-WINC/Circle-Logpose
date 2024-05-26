import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/user_service_facade.dart';
import '../../../domain/entity/user_profile.dart';

final userManagementControllerProvider =
    Provider<UserManagementController>(UserManagementController.new);

class UserManagementController {
  UserManagementController(this.ref);

  final Ref ref;

  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.fetchUserDocIdWithAccountId(accountId);
  }

  Future<UserProfile?> fetchUserProfile(String userId) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.fetchUserProfile(userId);
  }

  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.fetchUserProfileWithAccountId(accountId);
  }
}
