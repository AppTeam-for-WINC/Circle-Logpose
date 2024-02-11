import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../signup_controller.dart';

class SignupProgressIndicator extends ConsumerStatefulWidget {
  const SignupProgressIndicator({super.key});

  @override
  SignupProgressIndicatorState createState() => SignupProgressIndicatorState();
}

class SignupProgressIndicatorState
    extends ConsumerState<SignupProgressIndicator> {
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
