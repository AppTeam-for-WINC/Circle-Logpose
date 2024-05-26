import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/loading_progress.dart';

import '../../components/components/auth/log_in/log_in_section.dart';
import '../../components/components/navigation_bar/auth_navigation/auth_navigation_bar.dart';

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
      navigationBar: const AuthNavigationBar(),
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
            child: LogInSection(loadingErrorMessage: loadingErrorMessage),
          ),
        ),
      ),
    );
  }
}
