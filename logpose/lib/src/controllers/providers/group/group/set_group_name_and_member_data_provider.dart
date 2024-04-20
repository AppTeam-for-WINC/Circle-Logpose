import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupNameEditingProvider =
    Provider.family.autoDispose<TextEditingController, String>(
  (ref, name) => TextEditingController(text: name),
);
