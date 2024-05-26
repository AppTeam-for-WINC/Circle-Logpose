abstract class IGroupMemberIdUseCase {
  Future<String> fetchUserIdWithMembershipId(String membershipId);

  Future<List<String>> fetchAllUserDocIdWithGroupId(String groupId);

  Future<List<String>> fetchAllMembershipIdList(String groupId);

  Future<String> fetchMembershipIdWithGroupIdAndUserId(
    String groupId,
    String accountId,
  );
}
