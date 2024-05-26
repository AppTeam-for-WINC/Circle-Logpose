import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/interface/i_user_repository.dart';

import '../../../data/repository/database/user_repository.dart';

import '../../interface/auth/i_auth_user_id_use_case.dart';
import '../../interface/user/i_account_id_update_use_case.dart';

import '../usecase_auth/user_id_use_case.dart';

final accountIdUpdateUseCaseProvider = Provider<IAccountIdUpdateUseCase>(
  (ref) {
    final authIdUseCase = ref.read(authUserIdUseCaseProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final validator = ref.read(validatorControllerProvider);

    return AccountIdUpdateUseCase(
      ref: ref,
      authIdUseCase: authIdUseCase,
      userRepository: userRepository,
      validator: validator,
    );
  },
);

class AccountIdUpdateUseCase implements IAccountIdUpdateUseCase {
  const AccountIdUpdateUseCase({
    required this.ref,
    required this.authIdUseCase,
    required this.userRepository,
    required this.validator,
  });

  final Ref ref;
  final IAuthUserIdUseCase authIdUseCase;
  final IUserRepository userRepository;
  final ValidatorController validator;

  @override
  Future<String?> updateAccountId(String newAccountId) async {
    try {
      return await _attemptToUpdate(newAccountId);
    } on Exception catch (e) {
      return 'Error: failed to update account ID. $e';
    }
  }

  Future<String?> _attemptToUpdate(String newAccountId) async {
    final userId = await _fetchUserDocId();

    final validationError = validator.validateAccountId(newAccountId);
    if (validationError != null) {
      return validationError;
    }

    final updateProcess = await _updateAccountId(userId, newAccountId);
    if (!updateProcess) {
      return 'Failed to update account ID.';
    }

    return null;
  }

  Future<String> _fetchUserDocId() async {
    return authIdUseCase.fetchCurrentUserId();
  }

  Future<bool> _updateAccountId(String userId, String newAccountId) async {
    try {
      return await userRepository.updateAccountId(userId, newAccountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update account ID. ${e.message}');
    }
  }
}
