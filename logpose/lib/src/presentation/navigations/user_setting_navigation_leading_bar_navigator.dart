import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class UserSettingNavigationLeadingBarNavigator {
  UserSettingNavigationLeadingBarNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.push(
      context,
      CupertinoPageRoute<
          CupertinoPageRoute<ScheduleListAndJoinedGroupTabSlider>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
    );
  }
}
