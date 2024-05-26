// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageControllerProvider =
    StateNotifierProvider<_ImageControllerNotifier, File>(
  (ref) => _ImageControllerNotifier(),
);

class _ImageControllerNotifier extends StateNotifier<File> {
  _ImageControllerNotifier() : super(File(''));

  void setImagePath(File image) {
    state = image;
  }
}
