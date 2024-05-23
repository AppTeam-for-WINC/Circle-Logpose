import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navigations/move_to_login_button_navigator.dart';

class MoveToLogInButton extends ConsumerStatefulWidget {
  const MoveToLogInButton({super.key});

  @override
  ConsumerState<MoveToLogInButton> createState() => _MoveToLogInButtonState();
}

class _MoveToLogInButtonState extends ConsumerState<MoveToLogInButton> {
  Future<void> _handleToTap() async {
    final navigator = MoveToLogInButtonNavigator(context);
    await navigator.moveToPage();
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
          onPressed: _handleToTap,
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
