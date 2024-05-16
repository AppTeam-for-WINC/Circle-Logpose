import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../validator/validator_controller.dart';

import '../../providers/user/user_controller_provider.dart';
import '../auth_use_case.dart';
import '../user_use_case.dart';

class AccountIdUpdateHelper {
  const AccountIdUpdateHelper({
    required this.ref,
    required this.authUseCase,
    required this.userUseCase,
    required this.validator,
  });

  final Ref ref;
  final AuthUseCase authUseCase;
  final UserUseCase userUseCase;
  final ValidatorController validator;

  Future<String?> updateAccountId(String newAccountId) async {
    try {
      return await _attemptToUpdate(newAccountId);
    } on FirebaseException catch (e) {
      return 'Error: failed to update account ID. $e';
    }
  }

  Future<String?> _attemptToUpdate(String newAccountId) async {
    final userId = await _fetchUserDocId();
    if (userId == null) {
      return 'Error : No found user ID.';
    }

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

  Future<String?> _fetchUserDocId() async {
    try {
      return authUseCase.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
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
