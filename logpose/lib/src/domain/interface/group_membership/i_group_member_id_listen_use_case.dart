// ignore_for_file: one_member_abstracts

abstract class IGroupMemberIdListenUseCase {
  Stream<List<String?>> listenAllMembershipIdList(String groupId);
}
