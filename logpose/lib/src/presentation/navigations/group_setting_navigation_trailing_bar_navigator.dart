import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class GroupSettingNavigationTrailingBarNavigator {
  GroupSettingNavigationTrailingBarNavigator(this.context);

  final BuildContext context;

  Future<void> moveToScheduleListPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }

  void cancel() {
    Navigator.pop(context);
  }
}
