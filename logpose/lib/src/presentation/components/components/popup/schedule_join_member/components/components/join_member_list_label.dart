import 'package:flutter/cupertino.dart';

class JoinMemberListLabel extends StatelessWidget {
  const JoinMemberListLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: const Row(
        children: [
          Icon(CupertinoIcons.group, size: 25),
          SizedBox(width: 10),
          Text(
            '参加メンバー',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ],
      ),
    );
  }
}
