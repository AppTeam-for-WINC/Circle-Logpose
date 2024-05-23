import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';

final emailSaveButtonControllerProvider = Provider<EmailSaveButtonController>(
  EmailSaveButtonController.new,
);

class EmailSaveButtonController {
  EmailSaveButtonController(this.ref);
  final Ref ref;

  Future<String?> updateEmail(String newEmail, String password) async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.updateUserEmail(newEmail, password);
  }
}
