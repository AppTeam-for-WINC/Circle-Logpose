import 'package:flutter/cupertino.dart';

import '../pages/signup/sign_up_page.dart';

class MoveToSignUpButtonNavigator {
  MoveToSignUpButtonNavigator(this.context);
  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<SignUpPage>>(
        builder: (context) => const SignUpPage(),
      ),
    );
  }
}
