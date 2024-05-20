import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/repository/auth/auth_repository.dart';

import '../../interface/i_auth_repository.dart';

import 'email_use_case.dart';

final passwordUseCaseProvider = Provider.autoDispose<PasswordUseCase>((ref) {
  final emailUseCase = ref.read(emailUseCaseProvider);
  final authRepository = ref.read(authRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);

  return PasswordUseCase(
    ref: ref,
    emailUseCase: emailUseCase,
    authRepository: authRepository,
    validator: validator,
  );
});

class PasswordUseCase {
  PasswordUseCase({
    required this.ref,
    required this.emailUseCase,
    required this.authRepository,
    required this.validator,
  });

  final Ref ref;
  final EmailUseCase emailUseCase;
  final IAuthRepository authRepository;
  final ValidatorController validator;

  Future<String?> updateUserPassword(
    String password,
    String newPassword,
  ) async {
    try {
      return await _attemptToUpdatePassword(password, newPassword);
    } on FirebaseException catch (e) {
      return 'Failed to update password: ${e.message}';
    }
  }

  Future<String?> _attemptToUpdatePassword(
    String password,
    String newPassword,
  ) async {
    final passwordValidationError = validator.validatePassword(password);
    final newPasswordValidationError = validator.validatePassword(newPassword);

    if (passwordValidationError != null) {
      return passwordValidationError;
    }
    if (newPasswordValidationError != null) {
      return newPasswordValidationError;
    }

    final email = await emailUseCase.fetchUserEmail();
    if (email == null) {
      return "Failed to fetch user's email.";
    }

    return _updatePassword(email, password, newPassword);
  }

  Future<String?> _updatePassword(
    String email,
    String password,
    String newPassword,
  ) async {
    try {
      return await authRepository.updateUserPassword(
        email,
        password,
        newPassword,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update password. ${e.message}');
    }
  }
}
