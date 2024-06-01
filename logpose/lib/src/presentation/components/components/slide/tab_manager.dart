import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/responsive_util.dart';

import 'src/segment_tab.dart';
import 'tabs/group_creation_tab.dart';
import 'tabs/schedule_tab.dart';
import 'tabs/user_setting_tab.dart';

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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.16,
      paddingLeft: deviceWidth * 0.085,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.16,
      paddingLeft: deviceWidth * 0.07,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.16,
      paddingLeft: deviceWidth * 0.066,
    );
  }

  Widget _buildLayout({
    required double paddingTop,
    required double paddingLeft,
  }) {
    final tabName = widget.tabName;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop,
          left: paddingLeft,
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
      ),
    );
  }
}
