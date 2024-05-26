import 'package:flutter/cupertino.dart';

import '../app_logo_and_title.dart';

import '../progress_indicator.dart';
import '../red_error_message.dart';
import 'auth_email_field.dart';
import 'auth_password_field.dart';


class AuthSection extends StatefulWidget {
  const AuthSection({
    super.key,
    required this.loadingErrorMessage,
    required this.emailFieldLabel,
    required this.authButton,
  });

  final String? loadingErrorMessage;
  final String emailFieldLabel;
  final Widget authButton;

  @override
  State createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection> {
  @override
  Widget build(BuildContext context) {
    final loadingErrorMessage = widget.loadingErrorMessage;
    final emailFieldLabel = widget.emailFieldLabel;
    final authButton = widget.authButton;

    return Stack(
      alignment: Alignment.center,
      children: [
        const PageProgressIndicator(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppLogoAndTitle(),
            if (loadingErrorMessage != null)
              RedErrorMessage(
                errorMessage: loadingErrorMessage,
                fontSize: 20,
              ),
            AuthEmailField(label: emailFieldLabel),
            const AuthPasswordField(),
            authButton,
          ],
        ),
      ],
    );
  }
}
