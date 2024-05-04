import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/providers/group/schedule/image_provider.dart';
import '../entities/device/image_controller.dart';

class PhotoButton extends ConsumerStatefulWidget {
  const PhotoButton({super.key});
  @override
  ConsumerState<PhotoButton> createState() => _PhotoButtonState();
}

class _PhotoButtonState extends ConsumerState<PhotoButton> {
  Future<String> imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return 'no image';
      }
      ref.watch(imageControllerProvider.notifier).state = File(image.path);
      return 'Success: selected image.';
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
      return 'Failed';
    }
  }

  Future<void> _showPhotoAccessDeniedDialog(BuildContext context) async {
    try {
      await showPhotoAccessDeniedDialog(context);
    } on PlatformException catch (e) {
      debugPrint('Faield: $e');
    }
  }

  Future<void> _onPressed() async {
    final imageGetResult = await imagePicker();
    if (imageGetResult == 'Failed') {
      if (!mounted) {
        return;
      }
      await _showPhotoAccessDeniedDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _onPressed,
      child: const SizedBox(
        child: Icon(
          CupertinoIcons.photo,
          size: 60,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
