import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';
import '../../controllers/controllers/auth/login_controller.dart';
import '../../controllers/providers/auth/email_field_provider.dart';
import '../../controllers/providers/auth/password_field_provider.dart';

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  Future<String?> _login() async {
    return LoginController.login(
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

    final errorMessage = await _login();
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
          'Login',
          style: TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
