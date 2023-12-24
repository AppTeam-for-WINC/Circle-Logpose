import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login_controller.dart';

class LoginProgressIndicator extends ConsumerStatefulWidget {
  const LoginProgressIndicator({super.key});

  @override
  LoginProgressIndicatorState createState() => LoginProgressIndicatorState();
}

class LoginProgressIndicatorState
    extends ConsumerState<LoginProgressIndicator> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingJudgeProvider);
    if (isLoading) {
      return const Positioned.fill(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    } else {
      // Returns an empty widget when not loading.
      return const SizedBox.shrink();
    }
  }
}
