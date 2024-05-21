// ignore_for_file: one_member_abstracts

abstract class IGroupInvitationUseCase {
  Future<String> createAndFetchGroupInvitationLink(String groupId);
}
