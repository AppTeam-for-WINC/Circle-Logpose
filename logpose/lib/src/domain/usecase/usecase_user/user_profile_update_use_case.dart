import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/interface/i_user_repository.dart';
import '../../../data/repository/database/user_repository.dart';

import '../../interface/auth/i_auth_user_id_use_case.dart';
import '../../interface/user/i_user_profile_update_use_case.dart';

import '../../model/user_setting_model.dart';

import '../usecase_auth/user_id_use_case.dart';

final userProfileUpdateUseCaseProvider =
    Provider<IUserProfileUpdateUseCase>((ref) {
  final authIdUseCase = ref.read(authUserIdUseCaseProvider);
      final userRepository = ref.read(userRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);

  return UserProfileUpdateUseCase(
    ref: ref,
    authIdUseCase: authIdUseCase,
    userRepository: userRepository,
    validator: validator,
  );
});

class UserProfileUpdateUseCase implements IUserProfileUpdateUseCase {
  const UserProfileUpdateUseCase({
    required this.ref,
    required this.authIdUseCase,
    required this.userRepository,
    required this.validator,
  });

  final Ref ref;
  final IAuthUserIdUseCase authIdUseCase;
  final IUserRepository userRepository;
  final ValidatorController validator;

  @override
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
    return authIdUseCase.fetchCurrentUserId();
  }

  Future<void> _executeToUpdate(
    String userId,
    UserSettingParams userData,
  ) async {
    try {
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
