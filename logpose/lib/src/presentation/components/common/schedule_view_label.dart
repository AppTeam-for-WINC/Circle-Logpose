import 'package:flutter/cupertino.dart';

class ScheduleViewLabel extends StatelessWidget {
  const ScheduleViewLabel({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 25, color: CupertinoColors.systemGrey),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            label,
            style: const TextStyle(color: CupertinoColors.systemGrey),
          ),
        ),
      ],
    );
  }
}
