import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/repository/auth/auth_repository.dart';

final signUpUsecaseProvider = Provider<SignUpUseCase>(
  (ref) {
    final validator = ref.read(validatorControllerProvider);

    return SignUpUseCase(
      ref: ref,
      validator: validator,
    );
  },
);

class SignUpUseCase {
  SignUpUseCase({
    required this.ref,
    required this.validator,
  });

  final Ref ref;
  final ValidatorController validator;

  Future<String?> signUp(String email, String password) async {
    try {
      return await _executeSignUp(email, password);
    } on Exception catch (e) {
      return 'Error: failed to sign up.: $e';
    }
  }

  Future<String?> _executeSignUp(String email, String password) async {
    final validationError = _validateCredentials(email, password);
    if (validationError != null) {
      return validationError;
    }

    final success = await _createAccount(email, password);
    if (!success) {
      return 'Error: The email address is already in use by another account.';
    }

    return null;
  }

  String? _validateCredentials(String email, String password) {
    return validator.validateCredentials(email, password);
  }

  Future<bool> _createAccount(String email, String password) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.createAccount(email, password);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create account. ${e.message}');
    }
  }
}
