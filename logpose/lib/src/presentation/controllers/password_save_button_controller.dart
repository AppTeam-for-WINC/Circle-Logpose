import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';

final passwordSaveButtonControllerrProvider =
    Provider<PasswordSaveButtonController>(
  PasswordSaveButtonController.new,
);

class PasswordSaveButtonController {
  PasswordSaveButtonController(this.ref);
  final Ref ref;

  Future<String?> updateUserPassword(
    String password,
    String newPassword,
  ) async {
    final authFacade = ref.read(authFacadeProvider);

    return authFacade.updateUserPassword(password, newPassword);
  }
}
