import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../server/auth/auth_controller.dart';
import '../../../server/database/user_controller.dart';

import '../../validation/user/user_validation.dart';

class UpdateUserProfile {
  UpdateUserProfile._internal();
  static final UpdateUserProfile _instance = UpdateUserProfile._internal();
  static UpdateUserProfile get instance => _instance;

  /// Update user profile's database.
  static Future<String?> update(
    String name,
    File? image,
    String? description,
    WidgetRef ref,
  ) async {
    try {
      final imagePath = image?.path;

      final validation = UserValidation.validation(name);
      if (validation != null) {
        return 'Failed to update profile.';
      }

      final userId = await _fetchUserDocId();
      if (userId == null) {
        return 'Error: No userId';
      }

      await _updateUserProfile(
        userId,
        name,
        imagePath,
        description,
      );

      return null;
    } on Exception catch (e) {
      debugPrint('Error: Failed to update user profile. $e');
      return 'Error: Failed to update profile';
    }
  }

  static Future<String?> _fetchUserDocId() async {
    try {
      return AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
  }

  static Future<void> _updateUserProfile(
    String userId,
    String name,
    String? imagePath,
    String? description,
  ) async {
    try {
      await UserController.update(
        userId,
        name,
        imagePath,
        description,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user data. $e');
    }
  }
}
