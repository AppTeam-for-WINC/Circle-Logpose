import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/repository/auth_repository_provider.dart';
import '../../providers/repository/user_repository_provider.dart';

final userIdUseCaseProvider = Provider<UserIdUseCase>(
  (ref) => UserIdUseCase(ref: ref),
);

class UserIdUseCase {
  UserIdUseCase({required this.ref});

  final Ref ref;

  Future<String> fetchCurrentUserId() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final userId = await authRepository.fetchCurrentUserId();
      if (userId == null) {
        throw Exception('Error: failed to fetch user ID.');
      }
      return userId;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }

  Future<String?> fetchCurrentUserIdNullable() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      return await authRepository.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }

  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      return await userRepository.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }
}
