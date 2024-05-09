import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/async_group_schedule_list/async_group_schedule_list.dart';
import 'components/switch/add_schedule_switch.dart';
import 'components/switch/delete_schedule_switch.dart';

class ScheduleSection extends ConsumerStatefulWidget {
  const ScheduleSection({super.key, required this.groupId, this.groupName});
  final String groupId;
  final String? groupName;

  @override
  ConsumerState createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends ConsumerState<ScheduleSection> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final groupId = widget.groupId;

    return SizedBox(
      width: deviceWidth * 0.89,
      height: deviceHeight * 0.36,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: deviceWidth * 0.85,
              height: deviceHeight * 0.36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CupertinoColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Text(
                          '予定一覧',
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AsyncGroupScheduleList(groupId: groupId),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: AddScheduleSwitch(groupId: groupId),
          ),
          const Positioned(
            top: 60,
            right: 0,
            child: DeleteScheduleSwitch(),
          ),
        ],
      ),
    );
  }
}
