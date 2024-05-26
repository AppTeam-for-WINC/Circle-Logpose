import 'package:flutter/cupertino.dart';

import '../../../common/auth/auth_section.dart';
import 'log_in_button.dart';

class LogInSection extends StatelessWidget {
  const LogInSection({super.key, required this.loadingErrorMessage});

  final String? loadingErrorMessage;

  @override
  Widget build(BuildContext context) {
    return AuthSection(
      loadingErrorMessage: loadingErrorMessage,
      emailFieldLabel: 'メールアドレス',
      authButton: const LogInButton(),
    );
  }
}
