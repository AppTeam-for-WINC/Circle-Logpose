// ignore_for_file: one_member_abstracts

abstract class IGroupMemberExistUseCase {
  Future<bool> doesMemberExist(String groupId, String userId);
}
