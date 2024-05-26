import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);
