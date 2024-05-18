import '../entity/user_profile.dart';

abstract class IUserRepository {
  Future<void> createUser({
    required String docId,
    String? accountId,
    String? name,
    String? image,
    String? description,
  });

  Future<UserProfile> fetchUser(String docId);

  Stream<UserProfile?> listenUser(String docId);

  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId);

  Future<String> fetchUserDocIdWithAccountId(String accountId);

  Future<void> updateUser(
    String docId,
    String? name,
    String? image,
    String? description,
  );

  Future<bool> updateAccountId(String docId, String accountId);
}
