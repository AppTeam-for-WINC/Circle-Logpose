import 'package:amazon_app/pages/slide/src/slide_tab.dart';
import 'package:amazon_app/pages/slide/tabs/attendance_tab.dart';
import 'package:amazon_app/pages/slide/tabs/group_create_tab.dart';
import 'package:amazon_app/pages/slide/tabs/user_setting_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabComponent extends ConsumerStatefulWidget {
  const TabComponent({super.key, required this.tab, required this.tabName});
  final SegmentTab tab;
  final String tabName;

  @override
  ConsumerState createState() => TabComponentState();
}

class TabComponentState extends ConsumerState<TabComponent> {
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
          if (tabName == '出席簿') ... const [
            UserSettingTab(),
            SizedBox(height: 20),
            GroupCreateTab(),
          ],
          if (tabName == '団体作成') ... const [
            AttendanceTab(),
            SizedBox(height: 20),
            UserSettingTab(),
          ],
          if (tabName == 'ユーザー設定') ... const [
            AttendanceTab(),
            SizedBox(height: 20),
            GroupCreateTab(),
          ],
        ],
      ),
    );
  }
}
