import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_auth_repository.dart';

import '../../../data/repository/auth/auth_repository.dart';

import '../../interface/auth/i_auth_user_id_use_case.dart';

final authUserIdUseCaseProvider = Provider<IAuthUserIdUseCase>(
  (ref) {
      final authRepository = ref.read(authRepositoryProvider);

    return AuthUserIdUseCase(ref: ref, authRepository: authRepository);
  }
);

class AuthUserIdUseCase implements IAuthUserIdUseCase {
  AuthUserIdUseCase({required this.ref, required this.authRepository});

  final Ref ref;
  final IAuthRepository authRepository;

  @override
  Future<String> fetchCurrentUserId() async {
    try {
      final userId = await authRepository.fetchCurrentUserId();
      if (userId == null) {
        throw Exception('Error: failed to fetch user ID.');
      }
      return userId;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }

  @override
  Future<String?> fetchCurrentUserIdNullable() async {
    try {
      return await authRepository.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }
}
