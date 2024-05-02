import 'package:flutter/cupertino.dart';

import '../../views/src/start/start_page.dart';

class AuthNavigationBar extends CupertinoNavigationBar {
  AuthNavigationBar({super.key, required this.context})
      : super(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          leading: _leading(context),
        );
  final BuildContext context;

  static void _onPressed(BuildContext context) {
    Navigator.pop(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const StartPage(),
      ),
    );
  }

  static Widget _leading(BuildContext context) {
    return CupertinoButton(
      child: const Icon(
        CupertinoIcons.back,
        size: 25,
        color: CupertinoColors.white,
      ),
      onPressed: () => _onPressed(context),
    );
  }
}
