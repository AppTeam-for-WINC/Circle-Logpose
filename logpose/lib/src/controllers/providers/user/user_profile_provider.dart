import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user/user.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/user_controller.dart';

/// Set user profile.
final setUserProfileDataProvider =
    StateNotifierProvider<_UserProfileData, UserProfile?>(
  (ref) => _UserProfileData(),
);

class _UserProfileData extends StateNotifier<UserProfile?> {
  _UserProfileData() : super(null) {
    readUserData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController accountIdController = TextEditingController();

  Future<UserProfile> initUserProfile() async {
    try {
      final userId = await AuthController.getCurrentUserId();
      if (userId == null) {
        throw Exception('User not logged in.');
      }

      return await UserController.read(userId);
    } on Exception catch (e) {
      throw Exception('Error read user data: $e');
    }
  }

  Future<void> readUserData() async {
    try {
      final userProfile = await initUserProfile();
      nameController.text = userProfile.name;
      state = userProfile;
    } on Exception catch (e) {
      debugPrint('Error read user data: $e');
    }
  }

  void setNewImage(File newImage) {
    if (state != null) {
      state = UserProfile(
        accountId: state!.accountId,
        name: state!.name,
        image: newImage.path,
        createdAt: state!.createdAt,
      );
    }
  }

  void setNewAccountId(String newAccountId) {
    if (state != null) {
      state = UserProfile(
        accountId: newAccountId,
        name: state!.name,
        image: state!.image,
        createdAt: state!.createdAt,
      );
    }
  }
}
