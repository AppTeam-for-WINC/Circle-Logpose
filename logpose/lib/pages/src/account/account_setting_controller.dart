import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/auth/auth_controller.dart';
import '../../../database/user/user.dart';
import '../../../database/user/user_controller.dart';
import '../../../validation/validation.dart';

Future<UserProfile> readUserRef() async {
  final userId = await AuthController.getCurrentUserId();
  if (userId == null) {
    throw Exception('Error: No userId');
  }
  final userProfile = await UserController.read(userId);
  return userProfile;
}

///変更情報を取得するだけで、データベースには変更内容を適用しない。
final userProfileProvider =
    StateNotifierProvider.autoDispose<UserData, UserProfile?>((ref) => UserData());

class UserData extends StateNotifier<UserProfile?> {
  UserData() : super(null) {
    readUserData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController accountIdController = TextEditingController();

  Future<void> readUserData() async {
    try {
      final userProfile = await readUserRef();
      nameController.text = userProfile.name;
      state = userProfile;
    } on Exception catch (e) {
      debugPrint('Error read user data: $e');
    }
  }

  void changeImage(File newImage) {
    if (state != null) {
      state = UserProfile(
        accountId: state!.accountId,
        name: state!.name,
        image: newImage.path,
        createdAt: state!.createdAt,
      );
    }
  }

  void changeAccountId(String newAccountId) {
    if (state != null) {
      state = UserProfile(
        accountId: newAccountId,
        name: state!.name,
        image: state!.image,
        createdAt: state!.createdAt,
      );
    }
  }

  Future<void> initUserProfile() async {
    try {
      final userProfile = await readUserRef();
      state = userProfile;
    } on Exception catch (e) {
      debugPrint('Error read user data: $e');
    }
  }
}

///Changed userDB.
Future<bool> changeUserProfile(
  String name,
  File? image,
  // File? image,
  String? description,
  WidgetRef ref,
) async {
  String? imagePath;
  final validation = userValidation(name);
  if (!validation) {
    debugPrint('Failed to change profile.');
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

///User Validation
bool userValidation(String name) {
  const requiredValidation = RequiredValidation();
  const maxLength32Validation = MaxLength32Validation();
  final nameRequiredValidation = requiredValidation.validate(
    name,
    'name',
  );
  final nameMaxLength32Validation = maxLength32Validation.validate(
    name,
    'name',
  );
  if (!nameRequiredValidation) {
    final errorMessage =
        const RequiredValidation().getStringInvalidRequiredMessage();

    debugPrint('nameError: $errorMessage');
    return false;
  }
  if (!nameMaxLength32Validation) {
    final errorMessage =
        const MaxLength32Validation().getMaxLengthInvalidMessage();

    debugPrint('nameError: $errorMessage');
    return false;
  }

  return true;
}
