import 'package:flutter/cupertino.dart';

class GroupSettingMemberPanelLabel extends StatelessWidget {
  const GroupSettingMemberPanelLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'メンバー',
      style: TextStyle(
        fontSize: 15,
        color: Color(0xFF9A9A9A),
      ),
    );
  }
}
