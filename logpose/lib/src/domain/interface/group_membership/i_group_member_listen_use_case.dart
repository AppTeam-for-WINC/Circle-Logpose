import '../../entity/group_membership.dart';
import '../../entity/user_profile.dart';

abstract class IGroupMemberListenUseCase {
  Stream<List<UserProfile?>> listenAllMember(String groupId);

  Stream<List<GroupMembership?>> listenAllMembershipListWithUserId(
    String userDocId,
  );
}
