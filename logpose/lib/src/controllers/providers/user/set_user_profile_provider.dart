import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/user_controller.dart';

/// Set user profile.
final setUserProfileDataProvider =
    StateNotifierProvider.autoDispose<_UserProfileData, UserProfile?>(
  (ref) => _UserProfileData(),
);

class _UserProfileData extends StateNotifier<UserProfile?> {
  _UserProfileData() : super(null) {
    _initUserProfile();
  }
  
  TextEditingController accountIdController = TextEditingController();

  Future<void> _initUserProfile() async {
    try {
      final userId = await _fetchUserDocId();
      state = await _fetchUserProfile(userId);
    } on Exception catch (e) {
      state = null;
      throw Exception('Error read user data: $e');
    }
  }

  Future<String> _fetchUserDocId() async {
    final userId = await AuthController.getCurrentUserId();
    if (userId == null) {
      state = null;
      throw Exception('User not logged in.');
    }
    return userId;
  }

  Future<UserProfile> _fetchUserProfile(String userDocId) async {
    final userProfile = await UserController.watch(userDocId).first;
    if (userProfile == null) {
      state = null;
    }

    return userProfile!;
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
