import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_user_repository.dart';

import '../../../data/repository/database/user_repository.dart';

import '../../interface/user/i_user_id_use_case.dart';

final userIdUseCaseProvider = Provider<IUserIdUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);

  return UserIdUseCase(ref: ref, userRepository: userRepository);
});

class UserIdUseCase implements IUserIdUseCase {
  UserIdUseCase({required this.ref, required this.userRepository});

  final Ref ref;
  final IUserRepository userRepository;

  @override
  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    try {
      return await userRepository.fetchUserDocIdWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }
}
