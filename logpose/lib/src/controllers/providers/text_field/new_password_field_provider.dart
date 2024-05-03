import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPasswordFieldProvider =
    Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);
