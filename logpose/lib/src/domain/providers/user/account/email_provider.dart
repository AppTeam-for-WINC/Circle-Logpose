import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/auth/auth_repository.dart';

import '../../../validation/email_validation.dart';
import '../../error/email_error_message_provider.dart';

final userEmailProvider =
    StateNotifierProvider.autoDispose<_UserEmail, String?>(
  (ref) => _UserEmail(),
);

class _UserEmail extends StateNotifier<String?> {
  _UserEmail() : super(null) {
    initUserEmail();
  }

  Future<void> initUserEmail() async {
    final email = await _fetchEmail();
    if (email == null) {
      return;
    }
    state = email;
  }

  Future<String?> _fetchEmail() async {
    return AuthRepository.readEmail();
  }

  Future<bool> changeEmail(
    WidgetRef ref,
    String newEmail,
    String password,
  ) async {
    final validation = UserEmailValidation.validation(newEmail);
    if (validation != null) {
      ref.watch(emailErrorMessageProvider.notifier).state = validation;
      return false;
    }

    final emailVerification = await AuthRepository.sendConfirmationEmail();
    if (!emailVerification) {
      return false;
    }

    return AuthRepository.updateUserEmail(
      state!,
      newEmail,
      password,
    );
  }
}
