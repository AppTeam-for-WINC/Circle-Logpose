import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../usecase_auth/email_use_case.dart';
import '../usecase_auth/log_in_use_case.dart';
import '../usecase_auth/log_out_use_case.dart';
import '../usecase_auth/password_use_case.dart';
import '../usecase_auth/sign_up_use_case.dart';

final authFacadeProvider = Provider<AuthFacade>(
  (ref) => AuthFacade(ref: ref),
);

class AuthFacade {
  AuthFacade({required this.ref})
      : _signUpUseCase = ref.read(signUpUsecaseProvider),
        _logInUseCase = ref.read(logInUseCaseProvider),
        _emailUseCase = ref.read(emailUseCaseProvider),
        _passwordUseCase = ref.read(passwordUseCaseProvider),
        _logOutUseCase = ref.read(logOutUseCaseProvider);

  final Ref ref;
  final SignUpUseCase _signUpUseCase;
  final LogInUseCase _logInUseCase;
  final EmailUseCase _emailUseCase;
  final PasswordUseCase _passwordUseCase;
  final LogOutUseCase _logOutUseCase;

  Future<String?> signUp(String email, String password) async {
    return _signUpUseCase.signUp(email, password);
  }

  Future<String?> login(String email, String password) async {
    return _logInUseCase.logIn(email, password);
  }

  Future<String?> fetchUserEmail() async {
    return _emailUseCase.fetchUserEmail();
  }

  Future<bool> updateUserEmail(
    String oldEmail,
    String newEmail,
    String password,
  ) async {
    return _emailUseCase.updateUserEmail(oldEmail, newEmail, password);
  }

  Future<String?> updateUserPassword(
    String email,
    String password,
    String newPassword,
  ) async {
    return _passwordUseCase.updateUserPassword(email, password, newPassword);
  }

  Future<bool> sendConfirmationEmail() async {
    return _emailUseCase.sendConfirmationEmail();
  }

  Future<void> logOut() async {
    return _logOutUseCase.logOut();
  }
}
