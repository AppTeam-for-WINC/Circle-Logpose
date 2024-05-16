import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth/auth_controller_provider.dart';

final authUseCaseProvider = Provider<AuthUseCase>(
  (ref) => AuthUseCase(ref: ref),
);

class AuthUseCase {
  const AuthUseCase({required this.ref});
  final Ref ref;

  Future<String> fetchCurrentUserId() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userId = await authRepository.fetchCurrentUserId();
    if (userId == null) {
      throw Exception('Error: failed to fetch user ID.');
    }
    return userId;
  }

  Future<String?> fetchCurrentUserIdNullable() async {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.fetchCurrentUserId();
  }

  Future<bool> createAccount(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.createAccount(email, password);
  }

  Future<bool> loginToAccount(String email, String password) async {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.loginToAccount(email, password);
  }
}
