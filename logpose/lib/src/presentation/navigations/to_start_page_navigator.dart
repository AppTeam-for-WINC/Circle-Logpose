import 'package:flutter/cupertino.dart';

import '../pages/start/start_page.dart';

class ToStartPageNavigator {
  ToStartPageNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<StartPage>>(
        builder: (context) => const StartPage(),
      ),
    );
  }
}
