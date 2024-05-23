import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../device/image_controller.dart';

class PhotoButtonDialogNavigator {
  PhotoButtonDialogNavigator({required this.context});

  final BuildContext context;

  Future<void> showPhotoAccessDeniedDialog() async {
    try {
      await const DeviceManager().showPhotoAccessDeniedDialog(context);
    } on PlatformException catch (e) {
      debugPrint('Failed: $e');
    }
  }
}
