import 'package:amazon_app/controller/common/color_exchanger.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  const ScheduleCard({super.key, required this.schedule});
  final GroupSchedule schedule;
  @override
  ConsumerState<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends ConsumerState<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final groupSchedule = widget.schedule;

    return GestureDetector(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: hexToColor(groupSchedule.color),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Center(
          child: Text(
            groupSchedule.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 69, 68, 68),
            ),
          ),
        ),
      ),
    );
  }
}
