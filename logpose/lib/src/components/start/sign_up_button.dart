import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/signup/signup_page.dart';

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key});

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  Future<void> _onPressed() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const SignupPage(),
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
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.white,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: CupertinoButton(
          padding: const EdgeInsets.all(8),
          color: const Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(30),
          onPressed: _onPressed,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18,
              color: CupertinoColors.white,
              fontFamily: 'Shippori_Mincho_B1',
            ),
          ),
        ),
      ),
    );
  }
}
