import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/user_repository.dart';

import '../../entity/user_profile.dart';

final userProfileUseCaseProvider = Provider<UserProfileUseCase>(
  (ref) => UserProfileUseCase(ref: ref),
);

class UserProfileUseCase {
  UserProfileUseCase({required this.ref});

  final Ref ref;

  Future<UserProfile?> fetchUserProfile(String userId) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);

      return await userRepository.fetchUser(userId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);

      return await userRepository.fetchUserProfileWithAccountId(accountId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }
}
