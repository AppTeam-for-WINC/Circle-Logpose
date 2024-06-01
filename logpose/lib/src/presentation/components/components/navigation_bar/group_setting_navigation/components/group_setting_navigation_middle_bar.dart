import 'package:flutter/cupertino.dart';

class GroupSettingNavigationMiddleBar extends StatelessWidget {
  const GroupSettingNavigationMiddleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth * 0.4,
      margin: EdgeInsets.only(top: deviceHeight * 0.015),
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
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
    );
  }
}
