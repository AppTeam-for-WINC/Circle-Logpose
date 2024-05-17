import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/repository/auth_repository_provider.dart';

final passwordUseCaseProvider = Provider<PasswordUseCase>(
  (ref) => PasswordUseCase(ref: ref),
);

class PasswordUseCase {
  PasswordUseCase({required this.ref});

  final Ref ref;

  Future<String?> updateUserPassword(
    String email,
    String password,
    String newPassword,
  ) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.updateUserPassword(
        email,
        password,
        newPassword,
      );
    } on FirebaseException catch (e) {
      return 'Failed to update password: ${e.message}';
    }
  }
}
