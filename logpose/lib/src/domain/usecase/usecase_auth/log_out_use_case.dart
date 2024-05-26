import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_auth_repository.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../interface/auth/i_log_out_use_case.dart';

final logOutUseCaseProvider = Provider<ILogOutUseCase>(
  (ref) {
    final authRepository = ref.read(authRepositoryProvider);

    return LogOutUseCase(ref: ref, authRepository: authRepository,);
  }
);

class LogOutUseCase implements ILogOutUseCase {
  LogOutUseCase({required this.ref, required this.authRepository});

  final Ref ref;
  final IAuthRepository authRepository;

  @override
  Future<void> logOut() async {
    try {
      await authRepository.logOut();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to log out account. ${e.message}');
    }
  }
}
