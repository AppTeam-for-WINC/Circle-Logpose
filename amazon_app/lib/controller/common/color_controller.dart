import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleColorProvider =
    StateNotifierProvider<ScheduleColorNotifier, Color>((ref) {
  return ScheduleColorNotifier();
});

class ScheduleColorNotifier extends StateNotifier<Color> {
  ScheduleColorNotifier() : super(Colors.purple);

  set color(Color newColor) {
    state = newColor;
  }

  Color get color => state;
}
