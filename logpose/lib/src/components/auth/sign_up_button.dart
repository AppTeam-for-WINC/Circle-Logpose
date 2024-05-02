import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';
import '../../controllers/controllers/auth/signup_controller.dart';
import '../../controllers/providers/auth/email_field_provider.dart';
import '../../controllers/providers/auth/password_field_provider.dart';

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key});

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  Future<String?> _signUp() async {
    return SignupController.signup(
      context,
      ref,
      ref.read(emailFieldProvider('')),
      ref.read(passwordFieldProvider('')),
    );
  }

  void _loadingErrorMessage(String errorMessage) {
    LoadingProgressController.loadingErrorMessage(
      ref,
      errorMessage,
    );
  }

  Future<void> _onPressed() async {
    if (ref.watch(loadingProgressProvider)) {
      return;
    }

    final errorMessage = await _signUp();
    if (errorMessage != null) {
      _loadingErrorMessage(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 195,
      margin: const EdgeInsets.all(23),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: const Color.fromRGBO(80, 49, 238, 0.9),
        borderRadius: BorderRadius.circular(30),
        onPressed: _onPressed,
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
