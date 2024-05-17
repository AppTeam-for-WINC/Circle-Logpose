import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../providers/repository/auth_repository_provider.dart';
import '../../providers/validator/validator_controller_provider.dart';

final logInUseCaseProvider = Provider<LogInUseCase>(
  (ref) {
    final validator = ref.read(validatorControllerProvider);

    return LogInUseCase(ref: ref, validator: validator);
  },
);

class LogInUseCase {
  LogInUseCase({required this.ref, required this.validator});

  final Ref ref;
  final ValidatorController validator;

  Future<String?> logIn(String email, String password) async {
    try {
      return await _executeLogin(email, password);
    } on Exception catch (e) {
      return 'Error: failed to log in account.: $e';
    }
  }

  Future<String?> _executeLogin(String email, String password) async {
    final validationError = _validateCredentials(email, password);
    if (validationError != null) {
      return validationError;
    }

    final loginProcess = await _logInAccount(email, password);
    if (!loginProcess) {
      return 'Password or Email is not correct.';
    }

    return null;
  }

  String? _validateCredentials(String email, String password) {
    return validator.validateCredentials(email, password);
  }

  Future<bool> _logInAccount(String email, String password) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.logInAccount(email, password);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to log in account. ${e.message}');
    }
  }
}
