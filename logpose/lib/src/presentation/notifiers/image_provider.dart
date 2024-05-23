// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageControllerProvider =
    StateNotifierProvider<ImageControllerNotifier, File>(
  (ref) => ImageControllerNotifier(),
);

class ImageControllerNotifier extends StateNotifier<File> {
  ImageControllerNotifier() : super(File(''));

  void setImagePath(File image) {
    state = image;
  }
}
