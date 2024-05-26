import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';

final authAuthenticationControllerProvider =
    Provider<AuthAuthenticationController>(
  AuthAuthenticationController.new,
);

class AuthAuthenticationController {
  AuthAuthenticationController(this.ref);

  final Ref ref;

  Future<String?> signUp(String email, String password) async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.signUp(email, password);
  }

  Future<String?> logIn(String email, String password) async {
    final authfacade = ref.read(authFacadeProvider);
    return authfacade.logIn(email, password);
  }

  Future<void> logOut() async {
    final authFacade = ref.read(authFacadeProvider);
    await authFacade.logOut();
  }

  Future<bool> sendConfirmationEmail() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.sendConfirmationEmail();
  }
}
