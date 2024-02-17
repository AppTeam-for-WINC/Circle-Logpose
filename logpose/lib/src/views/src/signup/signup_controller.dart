import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/email_validation.dart';
import '../../../../validation/max_length_validation.dart';
import '../../../../validation/min_length_validation.dart';
import '../../../../validation/required_validation.dart';
import '../../../controllers/common/loading/loading_progress.dart';
import '../../../services/auth/auth_controller.dart';
import '../login/login_page.dart';

Future<String?> signupController(
  BuildContext context,
  WidgetRef ref,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  final email = emailController.text;
  final password = passwordController.text;
  const emailValidation = EmailValidation();
  const requiredValidation = RequiredValidation();
  const minLength8Validation = MinLength8Validation();
  const maxLength32Validation = MaxLength32Validation();

  final emailValidationJudge = emailValidation.validate(
    email,
    'email',
  );
  final emailRequiredValidationJudge = requiredValidation.validate(
    email,
    'email',
  );
  final emailMinLength8ValidationJudge = minLength8Validation.validate(
    email,
    'email',
  );
  final emailMaxLength32ValidationJudge = maxLength32Validation.validate(
    email,
    'email',
  );

  final passwordRequiredValidationJudge = requiredValidation.validate(
    password,
    'password',
  );
  final passwordMinLength8ValidationJudge = minLength8Validation.validate(
    password,
    'password',
  );
  final passwordMaxLength32ValidationJudge = maxLength32Validation.validate(
    password,
    'password',
  );

  if (!emailValidationJudge) {
    final errorMessage = const EmailValidation().emailInvalidMessage();

    debugPrint('emailError: $errorMessage');
    return errorMessage;
  }

  if (!emailRequiredValidationJudge) {
    final errorMessage =
        const RequiredValidation().getStringInvalidRequiredMessage();

    debugPrint('emailError: $errorMessage');
    return errorMessage;
  }

  if (!emailMinLength8ValidationJudge) {
    final errorMessage =
        const MinLength8Validation().getMinLengthInvalidMessage();

    debugPrint('emailError: $errorMessage');
    return errorMessage;
  }

  if (!emailMaxLength32ValidationJudge) {
    final errorMessage =
        const MaxLength32Validation().getMaxLengthInvalidMessage();

    debugPrint('emailError: $errorMessage');
    return errorMessage;
  }

  if (!passwordRequiredValidationJudge) {
    final errorMessage =
        const RequiredValidation().getStringInvalidRequiredMessage();

    debugPrint('passwordError: $errorMessage');
    return errorMessage;
  }

  if (!passwordMinLength8ValidationJudge) {
    final errorMessage =
        const MinLength8Validation().getMinLengthInvalidMessage();

    debugPrint('passwordError: $errorMessage');
    return errorMessage;
  }

  if (!passwordMaxLength32ValidationJudge) {
    final errorMessage =
        const MaxLength32Validation().getMaxLengthInvalidMessage();

    debugPrint('passwordError: $errorMessage');
    return errorMessage;
  }

  if (emailValidationJudge &&
      emailRequiredValidationJudge &&
      emailMinLength8ValidationJudge &&
      emailMaxLength32ValidationJudge &&
      passwordRequiredValidationJudge &&
      passwordMinLength8ValidationJudge &&
      passwordMaxLength32ValidationJudge) {
    LoadingProgressController.loadingProgress(ref, loading: true);
    final signupSuccess = await AuthController.createAccount(email, password);
    LoadingProgressController.loadingProgress(ref, loading: false);

    if (!signupSuccess) {
      return 'The email address is already in use by another account.';
    }

    if (signupSuccess) {
      // Check if the widget is still in the tree.
      if (context.mounted) {
        await Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const LoginPage(),
          ),
          (_) => false,
        );
      }
    }
  }
  return null;
}
