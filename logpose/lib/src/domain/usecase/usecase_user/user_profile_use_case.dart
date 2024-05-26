import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_user_repository.dart';
import '../../../data/repository/database/user_repository.dart';

import '../../entity/user_profile.dart';

import '../../interface/user/i_user_profile_use_case.dart';

final userProfileUseCaseProvider = Provider<IUserProfileUseCase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  
  return UserProfileUseCase(ref: ref, userRepository: userRepository);
});

class UserProfileUseCase implements IUserProfileUseCase {
  UserProfileUseCase({required this.ref, required this.userRepository});

  final Ref ref;
  final IUserRepository userRepository;

  @override
  Future<UserProfile?> fetchUserProfile(String userId) async {
    try {
      return await userRepository.fetchUser(userId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  @override
  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId) async {
    try {
      return await userRepository.fetchUserProfileWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }
}
