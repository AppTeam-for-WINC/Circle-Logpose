import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../database/auth/auth_controller.dart';
import '../../../../../validation/validation.dart';

final userEmailProvider =
    StateNotifierProvider.autoDispose<UserEmail, String?>((ref) => UserEmail());

class UserEmail extends StateNotifier<String?> {
  UserEmail() : super(null) {
    readUserEmail();
    emailController.text = '';
  }

  TextEditingController emailController = TextEditingController();
  String? userEmail;

  Future<void> readUserEmail() async {
    final email = await AuthController.readEmail();
    if (email == null) {
      return;
    }
    state = email;
    userEmail = email;
  }

  Future<bool> changeEmail(String newEmail) async {
    final validation = emailValidation(newEmail);
    if (!validation) {
      return false;
    }
    final emailVerification = await AuthController.sendConfirmationEmail();
    if (!emailVerification) {
      return false;
    }
    final success = await AuthController.updateUserEmail(userEmail!, newEmail);
    if (!success) {
      return false;
    }

    return true;
  }

  bool emailValidation(String newEmail) {
    const typeValidation = EmailValidation();
    const minLength8Validation = MinLength8Validation();
    const maxLength32Validation = MaxLength32Validation();

    final emailTypeValidation = typeValidation.validate(
      newEmail,
      'newEmail',
    );
    final emailMinLength8Validation = minLength8Validation.validate(
      newEmail,
      'newEmail',
    );
    final emailMaxLength32Validation = maxLength32Validation.validate(
      newEmail,
      'newEmail',
    );
    if (!emailTypeValidation) {
      final errorMessage = const EmailValidation().emailInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }
    if (!emailMinLength8Validation) {
      final errorMessage =
          const MinLength8Validation().getMinLengthInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }
    if (!emailMaxLength32Validation) {
       final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('emailError: $errorMessage');
      return false;
    }

    return true;
  }
}
