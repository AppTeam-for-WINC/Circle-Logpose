import 'package:flutter/material.dart';

import '../../../src/slide_segmented_tab_control.dart';

import 'components/joined_group_segment.dart';
import 'components/schedule_list_segment.dart';

class ScheduleListAndJoinedGroupSegmentView extends StatefulWidget {
  const ScheduleListAndJoinedGroupSegmentView({super.key});

  @override
  State createState() => _ScheduleListAndJoinedGroupSegmentViewState();
}

class _ScheduleListAndJoinedGroupSegmentViewState
    extends State<ScheduleListAndJoinedGroupSegmentView> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: deviceHeight * 0.065),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: deviceWidth * 0.88,
            height: deviceHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2.5,
                  spreadRadius: 2.5,
                  offset: Offset(0, 3),
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
              ],
              border: Border.all(color: const Color.fromRGBO(4, 49, 57, 0.05)),
            ),
            child: SegmentedTabControl(
              radius: const Radius.circular(999),
              backgroundColor: Colors.white,
              tabTextColor: Colors.black,
              selectedTabTextColor: Colors.white,
              height: deviceHeight * 0.063,
              tabs: [
                const ScheduleListSegment().buildLeftSegment(deviceWidth),
                const JoinedGroupSegment().buildRightSegment(deviceWidth),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
