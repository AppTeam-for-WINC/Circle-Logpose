import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/log_in_handler.dart';
import '../../../common/auth/auth_button.dart';

class LogInButton extends ConsumerWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleLogin() async {
      final loginHandler = LoginHandler(context, ref);
      await loginHandler.handleLogin();
    }

    return AuthButton(
      onPressed: handleLogin,
      label: 'Login',
    );
  }
}
