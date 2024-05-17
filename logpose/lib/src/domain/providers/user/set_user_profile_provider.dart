import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../usecase/facade/user_service_facade.dart';

final setUserProfileDataProvider =
    StateNotifierProvider.autoDispose<_UserProfileNotifier, UserProfile?>(
  _UserProfileNotifier.new,
);

class _UserProfileNotifier extends StateNotifier<UserProfile?> {
  _UserProfileNotifier(this.ref)
      : _userServiceFacade = ref.read(userServiceFacadeProvider),
        super(null) {
    _initUserProfile();
  }

  final StateNotifierProviderRef<_UserProfileNotifier, UserProfile?> ref;
  final UserServiceFacade _userServiceFacade;

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
    return _userServiceFacade.fetchCurrentUserId();
  }

  Future<UserProfile> _fetchUserProfile(String userDocId) async {
    return _userServiceFacade.fetchUserProfile(userDocId);
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
