import 'package:flutter/cupertino.dart';

class GroupSettingScheduleSectionPanelLabel extends StatelessWidget {
  const GroupSettingScheduleSectionPanelLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: [
          Text(
            '予定一覧',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
