import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../controllers/auth/auth_management_controller.dart';
import '../controllers/user/user_management_controller.dart';

final userProfileNotifierProvider =
    StateNotifierProvider.autoDispose<_UserProfileNotifier, UserProfile?>(
  _UserProfileNotifier.new,
);

class _UserProfileNotifier extends StateNotifier<UserProfile?> {
  _UserProfileNotifier(this.ref)
      :
      _authController = ref.read(authManagementControllerProvider),
       _userManagementController = ref.read(userManagementControllerProvider),
        super(null) {
    _init();
  }

  final Ref ref;
  final AuthManagementController _authController;
  final UserManagementController _userManagementController;

  Future<void> _init() async {
    try {
      await _executeToInit();
    } on Exception catch (e) {
      state = null;
      throw Exception('Error read user data: $e');
    }
  }

  Future<void> _executeToInit() async {
    final userId = await _authController.fetchCurrentUserId();
    state = await _userManagementController.fetchUserProfile(userId);
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
