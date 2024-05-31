import 'package:flutter/cupertino.dart';

class ScheduleTitle extends StatelessWidget {
  const ScheduleTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 120),
      width: deviceWidth * 0.5,
      child: Text(title, style: const TextStyle(fontSize: 26)),
    );
  }
}
