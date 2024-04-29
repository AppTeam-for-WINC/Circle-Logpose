import 'package:flutter/cupertino.dart';

class ScheduleError extends StatelessWidget {
  const ScheduleError({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: CupertinoColors.systemRed,
          fontSize: 14,
        ),
      ),
    );
  }
}
