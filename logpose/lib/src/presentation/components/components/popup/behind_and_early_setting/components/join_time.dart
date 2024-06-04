import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../../../../../utils/responsive_util.dart';
import 'components/end_picker_button.dart';
import 'components/start_picker_button.dart';

class JoinTime extends ConsumerStatefulWidget {
  const JoinTime({super.key, required this.groupData});

  final GroupProfileAndScheduleAndId groupData;

  @override
  ConsumerState createState() => _JoinTimeState();
}

class _JoinTimeState extends ConsumerState<JoinTime> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtil.isMobile(context)) {
          return _buildMobileLayout(deviceWidth, deviceHeight);
        } else if (ResponsiveUtil.isTablet(context)) {
          return _buildTabletLayout(deviceWidth, deviceHeight);
        } else {
          return _buildDesktopLayout(deviceWidth, deviceHeight);
        }
      },
    );
  }

  Widget _buildMobileLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.035,
      textSize: deviceWidth * 0.03,
      marginTop: deviceHeight * 0.2,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.025,
      textSize: deviceWidth * 0.02,
      marginTop: deviceHeight * 0.2,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      iconSize: deviceWidth * 0.02,
      textSize: deviceWidth * 0.015,
      marginTop: deviceHeight * 0.2,
    );
  }

  Widget _buildLayout({
    required double iconSize,
    required double textSize,
    required double marginTop,
  }) {
    final groupSchedule = widget.groupData.groupSchedule;
    final groupScheduleId = widget.groupData.groupScheduleId;

    return Container(
      margin: EdgeInsets.only(top: marginTop, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.calendar, size: iconSize),
              Text(
                '参加時間',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: textSize,
                ),
              ),
            ],
          ),
          Row(
            children: [
              StartPickerButton(
                groupSchedule: groupSchedule,
                groupScheduleId: groupScheduleId,
                textSize: textSize,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                child: Text('~', style: TextStyle(fontSize: textSize)),
              ),
              EndPickerButton(
                groupSchedule: groupSchedule,
                groupScheduleId: groupScheduleId,
                textSize: textSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
