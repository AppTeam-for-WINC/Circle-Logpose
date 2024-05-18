import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/auth/auth_repository.dart';

final emailUseCaseProvider = Provider<EmailUseCase>(
  (ref) => EmailUseCase(ref: ref),
);

class EmailUseCase {
  EmailUseCase({required this.ref});

  final Ref ref;

  Future<String?> fetchUserEmail() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.fetchUserEmail();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user email. ${e.message}');
    }
  }

  Future<bool> updateUserEmail(
    String oldEmail,
    String newEmail,
    String password,
  ) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.updateUserEmail(oldEmail, newEmail, password);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user email. ${e.message}');
    }
  }

  Future<bool> sendConfirmationEmail() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.sendConfirmationEmail();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to send confirmation email. ${e.message}');
    }
  }
}
