import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/user_controller.dart';

import '../../../validation/user/user_validation.dart';

// 今回は、シングルトンパターンだが、Providerで管理した方が便利である。
class UpdateUserProfile {
  UpdateUserProfile._internal();
  static final UpdateUserProfile _instance = UpdateUserProfile._internal();
  static UpdateUserProfile get instance => _instance;

  /// Update user profile's database.
  static Future<bool> update(
    String name,
    File? image,
    String? description,
    WidgetRef ref,
  ) async {
    String? imagePath;
    final validation = UserValidation.validation(name);
    if (!validation) {
      debugPrint('Failed to update profile.');
      return false;
    }

    final userId = await AuthController.getCurrentUserId();
    if (userId == null) {
      throw Exception('Error: No userId');
    }

    if (image == null) {
      imagePath = null;
    } else {
      imagePath = image.path;
    }

    await UserController.update(
      userId,
      name,
      imagePath,
      description,
    );

    debugPrint('Success: Changed profile');
    return true;
  }
}
