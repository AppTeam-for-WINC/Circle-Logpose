import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../validation/validator/validation/password_validation.dart';

import '../../../usecase/facade/auth_facade.dart';

import '../../text_field/new_password_field_provider.dart';
import '../../text_field/password_field_provider.dart';

final passwordSettingProvider = Provider.autoDispose<_UserPasswordSetting>(
  (ref) => _UserPasswordSetting(ref: ref),
);

// To-do modify.
class _UserPasswordSetting {
  _UserPasswordSetting({required this.ref});
  final Ref ref;

  Future<String?> update(WidgetRef ref) async {
    final password = ref.watch(passwordFieldProvider('')).text;
    final newPassword = ref.watch(newPasswordFieldProvider).text;
    final passwordError = _validationPassword(password);
    if (passwordError != null) {
      return passwordError;
    }
    final validationPasswordError = _validationPassword(newPassword);
    if (validationPasswordError != null) {
      return validationPasswordError;
    }

    // Get user email
    final email = await _fetchUserEmail();
    if (email == null) {
      return "Failed to read user's email.";
    }

    return _updateUserPassword(email, password, newPassword);
  }

  // Validate password
  String? _validationPassword(String password) {
    final passwordError = PasswordValidation.validation(password);
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }

  Future<String?> _updateUserPassword(
    String email,
    String password,
    String newPassword,
  ) async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.updateUserPassword(email, password, newPassword);
  }

  Future<String?> _fetchUserEmail() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.fetchUserEmail();
  }
}
