import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountIdErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);
