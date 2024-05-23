import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/sign_up_handler.dart';
import '../../../common/auth/auth_button.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleSignUp() async {
      final signUpHandler = SignUpHandler(context, ref);
      await signUpHandler.handleSignUp();
    }

    return AuthButton(
      onPressed: handleSignUp,
      label: 'Sign Up',
    );
  }
}
