import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import 'pop_navigator.dart';

class GroupSettingNavigationTrailingBarDialogNavigator {
  GroupSettingNavigationTrailingBarDialogNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<
          CupertinoPageRoute<ScheduleListAndJoinedGroupTabSlider>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }

  void cancel() {
    PopNavigator(context).pop();
  }
}
