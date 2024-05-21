import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';

final signUpControllerProvider = Provider<SignUpController>(
  SignUpController.new,
);

class SignUpController {
  SignUpController(this.ref);

  final Ref ref;

  Future<String?> performSignUp(String email, String password) async {
    try {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.signUp(email, password);

    } on Exception catch (e) {
      return'Error: unexpected error occured. $e';
    }
  }
}
