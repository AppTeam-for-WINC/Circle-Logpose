import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';
import '../../../data/interface/i_auth_repository.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../interface/auth/i_log_in_use_case.dart';

final logInUseCaseProvider = Provider<ILogInUseCase>(
  (ref) {
    final authRepository = ref.read(authRepositoryProvider);
    final validator = ref.read(validatorControllerProvider);

    return LogInUseCase(
      ref: ref,
      authRepository: authRepository,
      validator: validator,
    );
  },
);

class LogInUseCase extends ILogInUseCase {
  LogInUseCase({
    required this.ref,
    required this.authRepository,
    required this.validator,
  });

  final Ref ref;
  final IAuthRepository authRepository;
  final ValidatorController validator;

  @override
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
      return await authRepository.logInAccount(email, password);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to log in account. ${e.message}');
    }
  }
}
