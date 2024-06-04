import '../../domain/entity/group_membership.dart';
import '../../domain/entity/user_profile.dart';

abstract class IGroupMembershipRepository {
  Future<void> createMemmbership(
    String userDocId,
    String role,
    String groupId,
  );

  Future<List<String>> fetchAllMembershipIdList(String groupId);

  Stream<List<String>> listenAllMembershipIdList(String groupId);

  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId);

  Stream<List<String?>> watchAllUserDocIdWithGroupId(String groupId);

  Future<bool> doesMemberExist({
    required String groupId,
    required String userDocId,
  });

  Stream<List<UserProfile?>> listenAllMember(String groupId);

  Stream<List<UserProfile?>> listenAllUserProfileWithGroupIdAndRole(
    String groupId,
    String role,
  );

  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  );

  Future<GroupMembership> fetch(String docId);

  Future<String> fetchUserIdWithMembershipId(String docId);

  Future<String?> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String userId,
  );

  Future<void> update({
    required String docId,
    required String userId,
    required String username,
    required String? userDescription,
    required String role,
    required String groupId,
  });

  Future<void> delete(String docId);
}
