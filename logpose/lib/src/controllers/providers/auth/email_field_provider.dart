import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailFieldProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, email) => TextEditingController(text: email),
);
