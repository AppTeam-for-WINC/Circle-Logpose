import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pages/login/log_in_page.dart';

class MoveToLoginButton extends ConsumerStatefulWidget {
  const MoveToLoginButton({super.key});

  @override
  ConsumerState<MoveToLoginButton> createState() => _MoveToLoginButtonState();
}

class _MoveToLoginButtonState extends ConsumerState<MoveToLoginButton> {
  Future<void> _onPressed() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const LogInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 234,
      height: 60,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: CupertinoButton(
          padding: const EdgeInsets.all(8),
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(30),
          onPressed: _onPressed,
          child: const Text(
            'Login',
            style: TextStyle(
              color: Color.fromRGBO(80, 49, 238, 1),
              fontSize: 18,
              fontFamily: 'Shippori_Mincho_B1',
            ),
          ),
        ),
      ),
    );
  }
}
