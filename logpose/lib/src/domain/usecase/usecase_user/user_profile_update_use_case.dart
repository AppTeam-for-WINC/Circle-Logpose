import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../models/custom/user_setting_model.dart';

import '../../providers/repository/user_repository_provider.dart';

import '../../providers/validator/validator_controller_provider.dart';
import 'user_id_use_case.dart';

final userProfileUpdateUseCaseProvider =
    Provider<UserProfileUpdateUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final validator = ref.read(validatorControllerProvider);

  return UserProfileUpdateUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    validator: validator,
  );
});

class UserProfileUpdateUseCase {
  const UserProfileUpdateUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.validator,
  });

  final Ref ref;
  final UserIdUseCase userIdUseCase;
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
    await _executeToUpdate(userId, userData);

    return null;
  }

  String? _validateUser(String name) {
    return validator.validateUsername(name);
  }

  Future<String> _fetchUserDocId() async {
    return userIdUseCase.fetchCurrentUserId();
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
