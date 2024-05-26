import 'package:flutter/cupertino.dart';

import '../../../common/auth/auth_section.dart';

import 'sign_up_button.dart';

class SignUpSection extends StatelessWidget {
  const SignUpSection({super.key, required this.loadingErrorMessage});

  final String? loadingErrorMessage;

  @override
  Widget build(BuildContext context) {
    return AuthSection(
      loadingErrorMessage: loadingErrorMessage,
      emailFieldLabel: 'メールアドレス登録',
      authButton: const SignUpButton(),
    );
  }
}
