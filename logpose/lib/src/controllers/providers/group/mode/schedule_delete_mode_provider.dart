import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Switch mode of delete schedule.
final scheduleDeleteModeProvider =
    StateProvider.autoDispose<bool>((ref) => false);
