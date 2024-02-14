import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/common/loading_progress.dart';
import '../home/home_page.dart';
import '/database/auth/auth_controller.dart';
import '/validation/validation.dart';

Future<String?> loginController(
  BuildContext context,
  WidgetRef ref,
  TextEditingController emailController,
  TextEditingController passwordController,
  bool Function() isStillMounted,
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
    loadingJugeFunc(ref, judge: true);
    final loginSuccess = await AuthController.loginToAccount(email, password);
    loadingJugeFunc(ref, judge: false);

    if (!loginSuccess) {
      return 'Password or Email is not correct.';
    }

    if (loginSuccess) {
      if (context.mounted) {
        await Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const HomePage(),
          ),
          (_) => false,
        );
      }
    }
  }
  return null;
}
