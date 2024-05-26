import '../../entity/user_profile.dart';

abstract class IUserProfileUseCase {
  Future<UserProfile?> fetchUserProfile(String userId);

  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId);
}
