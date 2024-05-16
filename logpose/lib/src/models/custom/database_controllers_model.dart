import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetRefAndScheduleId {
  WidgetRefAndScheduleId({
    required this.ref,
    required this.groupScheduleId,
  });
  final WidgetRef ref;
  final String groupScheduleId;
}
