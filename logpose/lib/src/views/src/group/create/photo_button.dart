import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../entities/device/image_controller.dart';

class PhotoButton extends StatefulWidget {
  const PhotoButton({super.key});
  @override
  State<PhotoButton> createState() => _PhotoButtonState();
}

class _PhotoButtonState extends State<PhotoButton> {
  File? image;
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return 'no image';
      }
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
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
    final imageGetResult = await pickImage();
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
          size: 70,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
