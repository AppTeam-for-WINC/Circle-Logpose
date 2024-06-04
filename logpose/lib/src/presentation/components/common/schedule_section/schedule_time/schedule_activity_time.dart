import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../utils/responsive_util.dart';
import '../../../../../../utils/time_utils.dart';

import '../../../../navigations/modals/activity_time_picker_navigator.dart';
import '../../../../notifiers/group_schedule_notifier.dart';

class ScheduleActivityTime extends ConsumerStatefulWidget {
  const ScheduleActivityTime({super.key, this.groupScheduleId});

  final String? groupScheduleId;

  @override
  ConsumerState createState() => _ScheduleActivityTimeState();
}

class _ScheduleActivityTimeState extends ConsumerState<ScheduleActivityTime> {
  Future<void> _startAtPopup() async {
    final navigator = ActivityTimePickerNavigator(context);
    await navigator.showModalStartAt(widget.groupScheduleId);
  }

  Future<void> _endAtPopup() async {
    final navigator = ActivityTimePickerNavigator(context);
    await navigator.showModalEndAt(widget.groupScheduleId);
  }

  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

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
      paddingTop: 0,
      iconSize: deviceWidth * 0.038,
      textSize: deviceWidth * 0.038,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.02,
      iconSize: deviceWidth * 0.035,
      textSize: deviceWidth * 0.025,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      paddingTop: deviceHeight * 0.035,
      iconSize: deviceWidth * 0.03,
      textSize: deviceWidth * 0.018,
    );
  }

  Widget _buildLayout({
    required double paddingTop,
    required double iconSize,
    required double textSize,
  }) {
    final schedule =
        ref.watch(groupScheduleNotifierProvider(widget.groupScheduleId));
    if (schedule == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.schedule, size: iconSize, color: Colors.grey),
          ),
          CupertinoButton(
            onPressed: _startAtPopup,
            padding: EdgeInsets.zero,
            child: Consumer(
              builder: (context, watch, child) {
                return Text(
                  _formatDateTimeExcYear(schedule.startAt),
                  style: TextStyle(fontSize: textSize),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text('~', style: TextStyle(fontSize: textSize)),
          ),
          CupertinoButton(
            onPressed: _endAtPopup,
            padding: EdgeInsets.zero,
            child: Consumer(
              builder: (context, watch, child) {
                return Text(
                  _formatDateTimeExcYear(schedule.endAt),
                  style: TextStyle(fontSize: textSize),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
