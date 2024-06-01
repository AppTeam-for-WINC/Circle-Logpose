import 'package:flutter/cupertino.dart';

import '../../../../utils/responsive_util.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(
            loadingErrorMessage: loadingErrorMessage,
            emailFieldLabel: emailFieldLabel,
            authButton: authButton,
          );
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(
            loadingErrorMessage: loadingErrorMessage,
            emailFieldLabel: emailFieldLabel,
            authButton: authButton,
          );
        } else {
          return _buildDesktopLayout(
            loadingErrorMessage: loadingErrorMessage,
            emailFieldLabel: emailFieldLabel,
            authButton: authButton,
          );
        }
      },
    );
  }

  Widget _buildMobileLayout({
    required String? loadingErrorMessage,
    required String emailFieldLabel,
    required Widget authButton,
  }) {
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

  Widget _buildTabletLayout({
    required String? loadingErrorMessage,
    required String emailFieldLabel,
    required Widget authButton,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const PageProgressIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AppLogoAndTitle(),
              if (loadingErrorMessage != null)
                RedErrorMessage(
                  errorMessage: loadingErrorMessage,
                  fontSize: 22,
                ),
              AuthEmailField(label: emailFieldLabel),
              const AuthPasswordField(),
              authButton,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout({
    required String? loadingErrorMessage,
    required String emailFieldLabel,
    required Widget authButton,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const PageProgressIndicator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: const AppLogoAndTitle(),
              ),
            ),
            const SizedBox(width: 200),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (loadingErrorMessage != null)
                      RedErrorMessage(
                        errorMessage: loadingErrorMessage,
                        fontSize: 24,
                      ),
                    AuthEmailField(label: emailFieldLabel),
                    const AuthPasswordField(),
                    authButton,
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
