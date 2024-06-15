import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';

final authAccountDeletionControllerProvider =
    Provider<AuthAccountDeletionController>(
  AuthAccountDeletionController.new,
);

class AuthAccountDeletionController {
  AuthAccountDeletionController(this.ref);

  final Ref ref;

  Future<String?> deleteAccount(String email, String password) async {
    final authFacade = ref.read(authFacadeProvider);
    return await authFacade.deleteAccount(email, password);
  }
}
