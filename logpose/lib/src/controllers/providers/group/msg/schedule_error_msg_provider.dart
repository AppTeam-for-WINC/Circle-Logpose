import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);
