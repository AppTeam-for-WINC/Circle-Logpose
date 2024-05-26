abstract class IGroupMemberDeleteUseCase {
  Future<void> deleteMember(String membershipDocId);

  Future<void> deleteMemberWithGroupIdAndAccountId(
    String groupId,
    String accountId,
  );
}
