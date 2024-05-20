import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleTitle extends ConsumerWidget {
  const ScheduleTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      child: Text(title, style: const TextStyle(fontSize: 30)),
    );
  }
}
