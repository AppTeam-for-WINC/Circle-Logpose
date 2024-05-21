import '../../domain/entity/group_invitation.dart';

abstract class IGroupInvitationRepository {
  Future<GroupInvitation> create(String groupId);

  Future<GroupInvitation> fetch(String docId);

  Future<void> delete(String docId);
}
