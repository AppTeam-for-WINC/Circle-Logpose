import 'package:flutter/cupertino.dart';

import 'components/auth_navigation_leading_bar.dart';

class AuthNavigationBar extends CupertinoNavigationBar {
  const AuthNavigationBar({super.key})
      : super(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          leading: const AuthNavigationLeadingBar(),
        );
}
