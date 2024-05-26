import 'package:flutter/cupertino.dart';

import 'pop_navigator.dart';
import 'to_schedule_list_and_joined_group_tab_slider.dart';

class GroupSettingNavigationTrailingBarDialogNavigator {
  GroupSettingNavigationTrailingBarDialogNavigator(this.context);

  final BuildContext context;

  Future<void> moveToPage() async {
    final navigator = ToScheduleListAndJoinedGroupTabSliderNavigator(context);
    await navigator.moveToPage();
  }

  void cancel() {
    PopNavigator(context).pop();
  }
}
