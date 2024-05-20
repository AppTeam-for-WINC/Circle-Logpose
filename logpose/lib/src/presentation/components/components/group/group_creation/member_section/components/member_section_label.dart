import 'package:flutter/cupertino.dart';

class MemberSectionLabel extends StatelessWidget {
  const MemberSectionLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 30,
        bottom: 10,
      ),
      child: const Text(
        'メンバー',
        style: TextStyle(color: CupertinoColors.systemGrey),
      ),
    );
  }
}
