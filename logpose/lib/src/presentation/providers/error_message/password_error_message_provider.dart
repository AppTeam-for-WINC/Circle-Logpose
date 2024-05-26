import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);
