import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../navigations/dialogs/photo_button_dialog_navigator.dart';
import '../notifiers/image_provider.dart';

class PhotoButtonHandler {
  const PhotoButtonHandler({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;

  Future<void> handlePhoto() async {
    final imageGetResult = await _imagePicker();
    if (imageGetResult == 'Failed') {
      if (context.mounted) {
        await _showPhotoAccessDeniedDialog(context);
      }
    }
  }

  Future<String> _imagePicker() async {
    try {
      final image = await _pickImage();
      if (image == null) {
        return 'no image';
      }

      final imageFile = File(image.path);
      _setImagePath(imageFile);

      return 'Success: selected image.';
    } on PlatformException catch (e) {
      return 'Failed: $e';
    }
  }

  Future<XFile?> _pickImage() async {
    return ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void _setImagePath(File imageFile) {
    ref.watch(imageControllerProvider.notifier).setImagePath(imageFile);
  }

  Future<void> _showPhotoAccessDeniedDialog(BuildContext context) async {
    try {
      final navigator = PhotoButtonDialogNavigator(context: context);
      await navigator.showPhotoAccessDeniedDialog();
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
    }
  }
}
