import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageControllerProvider = StateProvider.autoDispose<File>(
  (ref) => File(''),
);
