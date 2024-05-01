import 'package:flutter/cupertino.dart';

import '../../../back_to_page_button/back_to_page_button.dart';

class GroupSettingHeader extends CupertinoNavigationBar {
  GroupSettingHeader({super.key, required this.context})
      : super(
          leading: const BackToPageButton(),
          backgroundColor: const Color.fromARGB(255, 233, 233, 246),
          border: const Border(
            bottom: BorderSide(color: Color.fromARGB(0, 0, 0, 0)),
          ),
          middle: _middle(context),
          trailing: _trailing(context),
        );
  final BuildContext context;

  static Widget _middle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
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
      child: const Center(
        child: Text(
          '団体編集',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  static void _pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> _onPressed(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('団体を削除しますか?'),
          content: const Text('削除後、元に戻すことはできません。'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _pop(context),
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _pop(context),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Widget _trailing(BuildContext context) {
    return CupertinoButton(
      onPressed: () => _onPressed(context),
      child: const Icon(
        CupertinoIcons.delete,
        color: Color(0xFF7B61FF),
        size: 25,
      ),
    );
  }
}
