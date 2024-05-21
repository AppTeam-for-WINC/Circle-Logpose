import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/loading_progress.dart';
import '../../components/common/progress_indicator.dart';
import '../../components/common/red_error_message.dart';
import '../../components/common/text_field/email_field.dart';
import '../../components/common/text_field/password_field.dart';

import '../../components/components/app_logo_and_title/app_logo_and_title.dart';
import '../../components/components/auth_button/log_in_button.dart';
import '../../components/components/navigation_bar/auth_navigation_bar.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogInScreen();
  }
}

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});
  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
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
                    const EmailField(label: 'メールアドレス'),
                    const PasswordField(),
                    const LogInButton(),
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
