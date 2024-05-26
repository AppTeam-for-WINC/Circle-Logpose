import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';

final authManagementControllerProvider =
    Provider<AuthManagementController>(
  AuthManagementController.new,
);

class AuthManagementController {
  AuthManagementController(this.ref);

  final Ref ref;

  Future<String> fetchCurrentUserId() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.fetchCurrentUserId();
  }

  Future<String?> fetchCurrentUserIdNullable() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.fetchCurrentUserIdNullable();
  }

  Future<String?> fetchUserEmail() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.fetchUserEmail();
  }
}
