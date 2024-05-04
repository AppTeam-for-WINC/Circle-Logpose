import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/text_field/account_id_field_provider.dart';
import '../../views/user/user_setting_page.dart';

class AccountIdSettingNavigationBar extends CupertinoNavigationBar {
  AccountIdSettingNavigationBar({
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
    _init(ref);
    await navigateBack(context);
  }

  static void _init(WidgetRef ref) {
    ref.read(accountIdFieldProvider('')).clear();
  }

  static Future<void> navigateBack(BuildContext context) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      await Navigator.pushReplacement(
        context,
        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
          builder: (_) => const UserSettingPage(),
        ),
      );
    }
  }
}
