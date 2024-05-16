import '../validator/validator_controller.dart';
import 'auth_use_case.dart';

/// Used with signUpControllerProvider.
class SignUpUseCase {
  SignUpUseCase({
    required this.authUseCase,
    required this.validator,
  });
  final AuthUseCase authUseCase;
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
    return authUseCase.createAccount(email, password);
  }
}
