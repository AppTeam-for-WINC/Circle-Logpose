import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/to_sign_up_page_navigator.dart';

class MoveToSignUpButton extends ConsumerStatefulWidget {
  const MoveToSignUpButton({super.key});

  @override
  ConsumerState<MoveToSignUpButton> createState() => _MoveToSignUpButtonState();
}

class _MoveToSignUpButtonState extends ConsumerState<MoveToSignUpButton> {
  Future<void> _handleToTap() async {
    final navigator = ToSignUpPageNavigator(context);
    await navigator.moveToPage();
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
          onPressed: _handleToTap,
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
