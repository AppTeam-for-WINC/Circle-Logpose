import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class LoginNavigator {
  LoginNavigator(this.context);
  final BuildContext context;

  Future<void> moveToNextPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<
          CupertinoPageRoute<ScheduleListAndJoinedGroupTabSlider>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }
}