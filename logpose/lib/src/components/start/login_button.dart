import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/src/login/login_page.dart';

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  Future<void> _onPressed() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const LoginPage(),
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
