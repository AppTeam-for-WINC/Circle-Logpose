import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordFieldProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, password) => TextEditingController(text: password),
);
