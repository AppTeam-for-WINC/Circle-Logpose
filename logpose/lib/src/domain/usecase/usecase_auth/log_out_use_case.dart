import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/repository/auth_repository_provider.dart';

final logOutUseCaseProvider = Provider<LogOutUseCase>(
  (ref) => LogOutUseCase(ref: ref),
);

class LogOutUseCase {
  LogOutUseCase({required this.ref});

  final Ref ref;

  Future<void> logOut() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.logOut();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to log out account. ${e.message}');
    }
  }
}
