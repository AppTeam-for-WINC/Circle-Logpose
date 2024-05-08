import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';

import '../../common/red_error_message.dart';
import '../../components/app_logo_and_title/app_logo_and_title.dart';
import '../../components/auth_button/login_button.dart';
import '../../components/navigation_bar/auth_navigation_bar.dart';
import '../../components/progress/progress_indicator.dart';
import '../../components/text_field/email_field.dart';
import '../../components/text_field/password_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LoginScreen();
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: AuthNavigationBar(context: context),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromRGBO(116, 85, 255, 0.56),
                  Color.fromRGBO(43, 0, 234, 0.18),
                ],
              ),
            ),
            child: Stack(
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
                    const EmailField(label: 'メールアドレス'),
                    const PasswordField(),
                    const LoginButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
