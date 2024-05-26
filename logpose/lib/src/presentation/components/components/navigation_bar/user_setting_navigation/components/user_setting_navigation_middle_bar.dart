import 'package:flutter/cupertino.dart';

class UserSettingNavigationMiddleBar extends StatelessWidget {
  const UserSettingNavigationMiddleBar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
