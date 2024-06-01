import 'package:flutter/material.dart';

import '../../../../../pages/group/joined_group_list_page.dart';
import '../../../../../pages/schedule/schedule_list_page.dart';

import 'components/schedule_list_and_joined_group_segment_view.dart';

class ScheduleListAndJoinedGroupTabSlider extends StatefulWidget {
  const ScheduleListAndJoinedGroupTabSlider({super.key});

  @override
  State<ScheduleListAndJoinedGroupTabSlider> createState() =>
      _ScheduleListAndJoinedGroupTabSliderState();
}

class _ScheduleListAndJoinedGroupTabSliderState
    extends State<ScheduleListAndJoinedGroupTabSlider> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: TabBarView(
                children: [ScheduleListPage(), JoinedGroupListPage()],
              ),
            ),
            ScheduleListAndJoinedGroupSegmentView(),
          ],
        ),
      ),
    );
  }
}
