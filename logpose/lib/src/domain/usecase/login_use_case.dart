import '../validator/validator_controller.dart';
import 'auth_use_case.dart';

/// Used with loginControllerProvider.
class LoginUseCase {
  LoginUseCase({
    required this.authUsecase,
    required this.validator,
  });
  final AuthUseCase authUsecase;
  final ValidatorController validator;

  Future<String?> login(String email, String password) async {
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

    final loginProcess = await _loginToAccount(email, password);
    if (!loginProcess) {
      return 'Password or Email is not correct.';
    }

    return null;
  }

  String? _validateCredentials(String email, String password) {
    return validator.validateCredentials(email, password);
  }

  Future<bool> _loginToAccount(String email, String password) async {
    return authUsecase.loginToAccount(email, password);
  }
}
