import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/interface/i_auth_repository.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../interface/auth/i_email_use_case.dart';

final emailUseCaseProvider = Provider<IEmailUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);
  return EmailUseCase(
    ref: ref,
    authRepository: authRepository,
    validator: validator,
  );
});

class EmailUseCase implements IEmailUseCase {
  EmailUseCase({
    required this.ref,
    required this.authRepository,
    required this.validator,
  });

  final Ref ref;
  final IAuthRepository authRepository;
  final ValidatorController validator;

  @override
  Future<String?> fetchUserEmail() async {
    try {
      return await authRepository.fetchUserEmail();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user email. ${e.message}');
    }
  }

  @override
  Future<String?> updateUserEmail(String newEmail, String password) async {
    try {
      return await _attemptToUpdate(newEmail, password);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user email. ${e.message}');
    }
  }

  Future<String?> _attemptToUpdate(String newEmail, String password) async {
    final credentialsValidation = validator.validateCredentials(
      newEmail,
      password,
    );

    if (credentialsValidation != null) {
      return credentialsValidation;
    }

    final emailConfirmation = await sendConfirmationEmail();
    if (!emailConfirmation) {
      return 'Failed to send confirmation email.';
    }

    final oldEmail = await fetchUserEmail();
    if (oldEmail == null) {
      throw Exception('Error: failed to fetch email');
    }

    final updateProcess = await _updateUserEmail(
      oldEmail,
      newEmail,
      password,
    );

    if (!updateProcess) {
      return 'Failed to update email.';
    }

    return null;
  }

  Future<bool> _updateUserEmail(
    String oldEmail,
    String newEmail,
    String password,
  ) async {
    try {
      return await authRepository.updateUserEmail(
        oldEmail,
        newEmail,
        password,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update email. ${e.message}');
    }
  }

  @override
  Future<bool> sendConfirmationEmail() async {
    try {
      return await authRepository.sendConfirmationEmail();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to send confirmation email. ${e.message}');
    }
  }
}
