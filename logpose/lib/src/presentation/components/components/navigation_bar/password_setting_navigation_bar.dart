import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pages/user/user_setting_page.dart';

class PasswordSettingNavigationBar extends CupertinoNavigationBar {
  PasswordSettingNavigationBar({
    super.key,
    required this.context,
    required this.ref,
  }) : super(
          leading: _leading(context, ref),
          backgroundColor: const Color.fromARGB(255, 245, 243, 254),
          border: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(0, 0, 0, 0),
            ),
          ),
        );
  final BuildContext context;
  final WidgetRef ref;

  static Widget _leading(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: () => _onPressed(context, ref),
      child: const Icon(
        CupertinoIcons.back,
        color: CupertinoColors.black,
      ),
    );
  }

  static Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<UserSettingPage>>(
        builder: (context) => const UserSettingPage(),
      ),
      (_) => false,
    );
  }
}
