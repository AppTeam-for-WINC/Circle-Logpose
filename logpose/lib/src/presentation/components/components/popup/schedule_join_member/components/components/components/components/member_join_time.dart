import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../domain/entity/group_member_schedule.dart';

import '../../../../../../../../../utils/responsive_util.dart';
import '../../../../../../../../../utils/time_utils.dart';

import '../../../../../../../../providers/group/schedule/listen_responesd_group_member_schedule_provider.dart';

class MemberJoinTime extends ConsumerStatefulWidget {
  const MemberJoinTime({
    super.key,
    required this.scheduleId,
    required this.accountId,
  });

  final String scheduleId;
  final String accountId;

  @override
  ConsumerState<MemberJoinTime> createState() => _MemberJoinTimeState();
}

class _MemberJoinTimeState extends ConsumerState<MemberJoinTime> {
  String _formatDateTimeExcYear(DateTime datetime) {
    return formatDateTimeExcYear(datetime);
  }

  Widget _buildJoinTime(GroupMemberSchedule memberSchedule, double textSize) {
    if (memberSchedule.lateness || memberSchedule.leaveEarly) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (memberSchedule.startAt != null)
            _buildTimeView(memberSchedule.startAt!, textSize),
          _buildDivision(textSize),
          if (memberSchedule.endAt != null)
            _buildTimeView(memberSchedule.endAt!, textSize),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTimeView(DateTime dateTime, double textSize) {
    return Text(
      _formatDateTimeExcYear(dateTime),
      style: TextStyle(fontSize: textSize),
    );
  }

  Widget _buildDivision(double textSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Text('|', style: TextStyle(fontSize: textSize)),
    );
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
      titleWidth: deviceWidth * 0.45,
      titleMarginTop: deviceHeight * 0.12,
      textSize: deviceWidth * 0.025,
    );
  }

  Widget _buildTabletLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.1,
      textSize: deviceWidth * 0.02,
    );
  }

  Widget _buildDesktopLayout(double deviceWidth, double deviceHeight) {
    return _buildLayout(
      titleWidth: deviceWidth * 0.5,
      titleMarginTop: deviceHeight * 0.08,
      textSize: deviceWidth * 0.018,
    );
  }

  Widget _buildLayout({
    required double titleWidth,
    required double titleMarginTop,
    required double textSize,
  }) {
    final asyncMemberSchedule = ref.watch(
      listenResponsedGroupMemberScheduleProvider(
        (scheduleId: widget.scheduleId, accountId: widget.accountId),
      ),
    );

    return asyncMemberSchedule.when(
      data: (memberSchedule) {
        if (memberSchedule == null) {
          return const SizedBox.shrink();
        }
        return _buildJoinTime(memberSchedule, textSize);
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
