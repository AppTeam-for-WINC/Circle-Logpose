import '../../entity/user_profile.dart';

abstract class IGroupMemberCreationUseCase {
  Future<void> createAdminRole(String userDocId, String groupId);

  Future<void> createMembershipRole(String memberDocId, String groupId);

  Future<void> createAllMembershipRole(
    String groupId,
    List<UserProfile> memberList,
  );
}
