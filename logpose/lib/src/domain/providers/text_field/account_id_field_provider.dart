import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountIdFieldProvider =
    StateProvider.autoDispose.family<TextEditingController, String>(
  (ref, accountId) => TextEditingController(text: accountId),
);
