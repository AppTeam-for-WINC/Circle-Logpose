import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/custom/user_setting_model.dart';

import '../../../server/auth/auth_controller.dart';
import '../../../server/database/user_controller.dart';

import '../../validation/user/user_validation.dart';

/// Used with user_setting_updater_provider
class UserSettingUpdater {
  const UserSettingUpdater();

  Future<String?> update(UserSettingParams userData) async {
    try {
      return await _attemptToUpdate(userData);
    } on Exception catch (e) {
      debugPrint('Error: Failed to update user profile. $e');
      return 'Error: Failed to update profile';
    }
  }

  Future<String?> _attemptToUpdate(UserSettingParams userData) async {
    final validation = UserValidation.validation(userData.name);
    if (validation != null) {
      return 'Failed to update profile.';
    }

    final userId = await _fetchUserDocId();
    if (userId == null) {
      return 'Error: No userId';
    }

    await _updateUserProfile(userId, userData);

    return null;
  }

  Future<String?> _fetchUserDocId() async {
    try {
      return await AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
  }

  Future<void> _updateUserProfile(
    String userId,
    UserSettingParams userData,
  ) async {
    try {
      await UserController.update(
        userId,
        userData.name,
        userData.image?.path,
        userData.description,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user profile. ${e.message}');
    }
  }
}
