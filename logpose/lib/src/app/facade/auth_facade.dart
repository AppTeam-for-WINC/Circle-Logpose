import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interface/auth/I_account_deletion_use_case.dart';
import '../../domain/interface/auth/i_auth_user_id_use_case.dart';
import '../../domain/interface/auth/i_email_use_case.dart';
import '../../domain/interface/auth/i_log_in_use_case.dart';
import '../../domain/interface/auth/i_log_out_use_case.dart';
import '../../domain/interface/auth/i_password_use_case.dart';
import '../../domain/interface/auth/i_sign_up_use_case.dart';

import '../../domain/usecase/usecase_auth/account_deletion_use_case.dart';
import '../../domain/usecase/usecase_auth/email_use_case.dart';
import '../../domain/usecase/usecase_auth/log_in_use_case.dart';
import '../../domain/usecase/usecase_auth/log_out_use_case.dart';
import '../../domain/usecase/usecase_auth/password_use_case.dart';
import '../../domain/usecase/usecase_auth/sign_up_use_case.dart';
import '../../domain/usecase/usecase_auth/user_id_use_case.dart';

final authFacadeProvider = Provider<AuthFacade>(
  (ref) => AuthFacade(ref: ref),
);

class AuthFacade {
  AuthFacade({required this.ref})
      : _signUpUseCase = ref.read(signUpUsecaseProvider),
        _logInUseCase = ref.read(logInUseCaseProvider),
        _logOutUseCase = ref.read(logOutUseCaseProvider),
        _authIdUseCase = ref.read(authUserIdUseCaseProvider),
        _emailUseCase = ref.read(emailUseCaseProvider),
        _passwordUseCase = ref.read(passwordUseCaseProvider),
        _accountDeletionUseCase = ref.read(accountDeletionUseCaseProvider);

  final Ref ref;
  final ISignUpUseCase _signUpUseCase;
  final ILogInUseCase _logInUseCase;
  final ILogOutUseCase _logOutUseCase;
  final IAuthUserIdUseCase _authIdUseCase;
  final IEmailUseCase _emailUseCase;
  final IPasswordUseCase _passwordUseCase;
  final IAccountDeletionUseCase _accountDeletionUseCase;

  Future<String?> signUp(String email, String password) async {
    return _signUpUseCase.signUp(email, password);
  }

  Future<String?> logIn(String email, String password) async {
    return _logInUseCase.logIn(email, password);
  }

  Future<void> logOut() async {
    return _logOutUseCase.logOut();
  }

  Future<String> fetchCurrentUserId() async {
    return _authIdUseCase.fetchCurrentUserId();
  }

  Future<String?> fetchCurrentUserIdNullable() async {
    return _authIdUseCase.fetchCurrentUserIdNullable();
  }

  Future<String?> fetchUserEmail() async {
    return _emailUseCase.fetchUserEmail();
  }

  Future<String?> updateUserEmail(
    String newEmail,
    String password,
  ) async {
    return _emailUseCase.updateUserEmail(newEmail, password);
  }

  Future<String?> updateUserPassword(
    String password,
    String newPassword,
  ) async {
    return _passwordUseCase.updateUserPassword(password, newPassword);
  }

  Future<bool> sendConfirmationEmail() async {
    return _emailUseCase.sendConfirmationEmail();
  }

  Future<String?> deleteAccount(String email, String password) async {
    return _accountDeletionUseCase.deleteAccount(email, password);
  }
}
