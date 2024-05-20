import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/repository/database/user_repository.dart';

import 'user_id_use_case.dart';

final accountIdUpdateUseCaseProvider = Provider<AccountIdUpdateUseCase>(
  (ref) {
    final validator = ref.read(validatorControllerProvider);

    return AccountIdUpdateUseCase(ref: ref, validator: validator);
  },
);

class AccountIdUpdateUseCase {
  const AccountIdUpdateUseCase({required this.ref, required this.validator});

  final Ref ref;
  final ValidatorController validator;

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
    final userIdUseCase = ref.read(userIdUseCaseProvider);
    return userIdUseCase.fetchCurrentUserId();
  }

  Future<bool> _updateAccountId(String userId, String newAccountId) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      return await userRepository.updateAccountId(userId, newAccountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update account ID. ${e.message}');
    }
  }
}
