import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';

final logInControllerProvider = Provider<LogInController>(
  LogInController.new,
);

class LogInController {
  LogInController(this.ref);
  final Ref ref;

  Future<String?> performLogin(String email, String password) async {
    try {
      final authfacade = ref.read(authFacadeProvider);
      return await authfacade.logIn(email, password);
    } on Exception catch (e) {
      return 'Error: unexpected error occured. $e';
    }
  }
}
