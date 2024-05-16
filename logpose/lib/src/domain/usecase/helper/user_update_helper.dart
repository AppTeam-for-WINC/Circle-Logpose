import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/user_setting_model.dart';

import '../../validator/validator_controller.dart';

import '../../providers/user/user_controller_provider.dart';

import '../auth_use_case.dart';
import '../user_use_case.dart';

class UserUpdateHelper {
  const UserUpdateHelper({
    required this.ref,
    required this.authUseCase,
    required this.userUseCase,
    required this.validator,
  });

  final Ref ref;
  final AuthUseCase authUseCase;
  final UserUseCase userUseCase;
  final ValidatorController validator;

  Future<String?> updateUser(UserSettingParams userData) async {
    try {
      return await _attemptToUpdate(userData);
    } on Exception catch (e) {
      return 'Error: Failed to update profile $e';
    }
  }

  Future<String?> _attemptToUpdate(UserSettingParams userData) async {
    final validation = _validateUser(userData.name);
    if (validation != null) {
      return validation;
    }

    final userId = await _fetchUserDocId();
    if (userId == null) {
      throw Exception('Error: User ID is not found.');
    }

    await _executeToUpdate(userId, userData);

    return null;
  }

  String? _validateUser(String name) {
    return validator.validateUsername(name);
  }

  Future<String?> _fetchUserDocId() async {
    return authUseCase.fetchCurrentUserId();
  }

  Future<void> _executeToUpdate(
    String userId,
    UserSettingParams userData,
  ) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.updateUser(
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
