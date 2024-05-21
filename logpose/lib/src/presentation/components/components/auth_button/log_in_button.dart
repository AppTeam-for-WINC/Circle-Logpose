import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../handlers/log_in_handler.dart';

class LogInButton extends ConsumerStatefulWidget {
  const LogInButton({super.key});

  @override
  ConsumerState<LogInButton> createState() => _LogInButtonState();
}

class _LogInButtonState extends ConsumerState<LogInButton> {
  Future<void> handleLogin() async {
   final loginHandler = LoginHandler(context, ref);
   await loginHandler.handleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 195,
      margin: const EdgeInsets.all(23),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: const Color.fromRGBO(80, 49, 238, 0.9),
        borderRadius: BorderRadius.circular(30),
        onPressed: handleLogin,
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Shippori_Mincho_B1',
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
