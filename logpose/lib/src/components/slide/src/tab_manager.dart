import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tabs/group_creation_tab.dart';
import '../tabs/schedule_tab.dart';
import '../tabs/user_setting_tab.dart';
import 'slide_tab.dart';

class TabManager extends ConsumerStatefulWidget {
  const TabManager({super.key, required this.tab, required this.tabName});
  final SegmentTab tab;
  final String tabName;

  @override
  ConsumerState createState() => TabComponentState();
}

class TabComponentState extends ConsumerState<TabManager> {
  @override
  Widget build(BuildContext context) {
    final tab = widget.tab;
    final tabName = tab.name!;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: deviceHeight * 0.15,
        right: 170,
      ),
      child: Column(
        children: [
          if (tabName == '出席簿') ...const [
            GroupCreationTab(),
            SizedBox(height: 20),
            UserSettingTab(),
          ],
          if (tabName == '団体作成') ...const [
            ScheduleTab(),
            SizedBox(height: 20),
            UserSettingTab(),
          ],
          if (tabName == 'ユーザー設定') ...const [
            ScheduleTab(),
            SizedBox(height: 20),
            GroupCreationTab(),
          ],
        ],
      ),
    );
  }
}
