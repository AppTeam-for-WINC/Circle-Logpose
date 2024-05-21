import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';
import '../../app/facade/user_service_facade.dart';

import '../../domain/entity/user_profile.dart';

final userProfileNotifierProvider =
    StateNotifierProvider.autoDispose<_UserProfileNotifier, UserProfile?>(
  _UserProfileNotifier.new,
);

class _UserProfileNotifier extends StateNotifier<UserProfile?> {
  _UserProfileNotifier(this.ref)
      : _userServiceFacade = ref.read(userServiceFacadeProvider),
        super(null) {
    _init();
  }

  final Ref ref;
  final UserServiceFacade _userServiceFacade;

  Future<void> _init() async {
    try {
      await _executeToInit();
    } on Exception catch (e) {
      state = null;
      throw Exception('Error read user data: $e');
    }
  }

  Future<void> _executeToInit() async {
    final authFacade = ref.read(authFacadeProvider);
    final userId = await authFacade.fetchCurrentUserId();
    state = await _userServiceFacade.fetchUserProfile(userId);
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
