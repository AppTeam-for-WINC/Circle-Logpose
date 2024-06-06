abstract class IStorageRepository {
  Future<String> uploadUserImageToStorage(String userId, String image);

  Future<String> uploadGroupImageToStorage(String groupId, String image);

  Future<String> downloadGroupDefaultImageToStorage();

  Future<String> downloadUserDefaultImageToStorage();

  Future<void> deleteGroupStorage(String groupId);

  Future<void> deleteUserStorage(String userId);
}
