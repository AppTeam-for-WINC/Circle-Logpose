import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../validation/validator/validation/email_validation.dart';

import '../../../usecase/facade/auth_facade.dart';

import '../../error/email_error_message_provider.dart';

final userEmailProvider =
    StateNotifierProvider.autoDispose<_UserEmail, String?>(
  (ref) => _UserEmail(ref: ref),
);

class _UserEmail extends StateNotifier<String?> {
  _UserEmail({required this.ref}) : super(null) {
    initUserEmail();
  }

  final Ref ref;

  Future<void> initUserEmail() async {
    final email = await _fetchEmail();
    if (email == null) {
      return;
    }
    state = email;
  }

  Future<String?> _fetchEmail() async {
    final authFacade = ref.read(authFacadeProvider);
    return authFacade.fetchUserEmail();
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

    final authFacade = ref.read(authFacadeProvider);
    final emailVerification = await authFacade.sendConfirmationEmail();
    if (!emailVerification) {
      return false;
    }
    return authFacade.updateUserEmail(
      state!,
      newEmail,
      password,
    );
  }
}
