import 'package:flutter/cupertino.dart';

import '../../../../../navigations/to_schedule_list_and_joined_group_tab_slider.dart';

class UserSettingNavigationLeadingBar extends StatelessWidget {
  const UserSettingNavigationLeadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = ToScheduleListAndJoinedGroupTabSliderNavigator(context);
      await navigator.moveToPage();
    }

    return CupertinoButton(
      onPressed: handleToTap,
      child: const Icon(
        CupertinoIcons.back,
        color: Color(0xFF7B61FF),
      ),
    );
  }
}
