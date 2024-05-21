import 'package:flutter/cupertino.dart';

import '../components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class GroupCreationNavigator {
  GroupCreationNavigator(this.context);

  final BuildContext context;

  Future<void> pushAndRemoveUntil() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) {
          return const ScheduleListAndJoinedGroupTabSlider();
        },
      ),
      (_) => false,
    );
  }
}
