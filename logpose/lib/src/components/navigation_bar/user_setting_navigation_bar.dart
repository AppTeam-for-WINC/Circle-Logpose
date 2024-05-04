import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth/auth_controller.dart';
import '../../views/start/start_page.dart';
import '../slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class UserSettingNavigationBar extends CupertinoNavigationBar {
  UserSettingNavigationBar({
    super.key,
    required this.context,
    required this.ref,
    required this.mounted,
  }) : super(
          leading: _leading(context, ref, mounted),
          backgroundColor: const Color(0xFFF5F3FE),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
          middle: _middle(),
          trailing: _trailing(context, ref, mounted),
        );
  final BuildContext context;
  final WidgetRef ref;
  final bool mounted;

  static Widget _leading(BuildContext context, WidgetRef ref, bool mounted) {
    return CupertinoButton(
      onPressed: () => _backToPage(context, ref, mounted),
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }

  static Widget _middle() {
    return Container(
      width: 178,
      height: 38,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD9D9D9),
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
        color: const Color(0xFF7B61FF),
        borderRadius: BorderRadius.circular(80),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.settings_solid, color: CupertinoColors.white),
          Text('ユーザー設定', style: TextStyle(color: CupertinoColors.white)),
        ],
      ),
    );
  }

  static Widget _trailing(BuildContext context, WidgetRef ref, bool mounted) {
    return CupertinoButton(
      onPressed: () => _showPopup(context, mounted),
      child: const Icon(
        CupertinoIcons.square_arrow_right,
        color: CupertinoColors.black,
        size: 30,
      ),
    );
  }

  static Future<void> _backToPage(
    BuildContext context,
    WidgetRef ref,
    bool mounted,
  ) async {
    if (!mounted) {
      return;
    }
    await _moveToSlider(context);
  }

  static Future<void> _moveToSlider(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
    );
  }

  static Future<void> _showPopup(BuildContext context, bool mounted) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('ログアウトしますか?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _popup(context),
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _dialogAction(context, mounted),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static void _popup(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> _dialogAction(BuildContext context, bool mounted) async {
    await _logout();

    if (!mounted) {
      return;
    }
    await _moveToStartPage(context);
  }

  static Future<void> _logout() async {
    await AuthController.logout();
  }

  static Future<void> _moveToStartPage(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const StartPage(),
      ),
    );
  }
}
