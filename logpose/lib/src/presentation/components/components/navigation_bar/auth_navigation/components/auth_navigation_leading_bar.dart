import 'package:flutter/cupertino.dart';

import '../../../../common/back_to_page_button.dart';

class AuthNavigationLeadingBar extends StatelessWidget {
  const AuthNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackToPageButton(iconColor: CupertinoColors.white);
  }
}
