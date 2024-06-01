import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group/schedule_list_and_joined_group_tab_slider.dart';

class ToScheduleListAndJoinedGroupTabSliderNavigator {
  ToScheduleListAndJoinedGroupTabSliderNavigator(this.context);

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
}
