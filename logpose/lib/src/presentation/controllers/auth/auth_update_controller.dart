import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';

final authUpdateControllerProvider =
    Provider<AuthUpdateController>(AuthUpdateController.new);

class AuthUpdateController {
  AuthUpdateController(this.ref);

  final Ref ref;

  Future<String?> updateUserEmail(
    String newEmail,
    String password,
  ) async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.updateUserEmail(newEmail, password);
  }

  Future<String?> updateUserPassword(
    String password,
    String newPassword,
  ) async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.updateUserPassword(password, newPassword);
  }
}
