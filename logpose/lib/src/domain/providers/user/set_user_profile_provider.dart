import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';

import '../../usecase/auth_use_case.dart';
import '../../usecase/user_use_case.dart';

final setUserProfileDataProvider =
    StateNotifierProvider.autoDispose<_UserProfileNotifier, UserProfile?>(
  _UserProfileNotifier.new,
);

class _UserProfileNotifier extends StateNotifier<UserProfile?> {
  _UserProfileNotifier(this.ref)
      : authController = ref.read(authUseCaseProvider),
        userController = ref.read(userUseCaseProvider),
        super(null) {
    _initUserProfile();
  }

  final StateNotifierProviderRef<_UserProfileNotifier, UserProfile?> ref;
  final AuthUseCase authController;
  final UserUseCase userController;

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
    return authController.fetchCurrentUserId();
  }

  Future<UserProfile> _fetchUserProfile(String userDocId) async {
    return userController.fetchUserProfile(userDocId);
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
