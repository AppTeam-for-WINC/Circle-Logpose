import '../../entity/user_profile.dart';

abstract class IGroupMemberListenByRoleUseCase {
  Stream<List<UserProfile?>> listenAllAdminProfile(String groupId);

  Stream<List<UserProfile?>> listenAllMembershipProfile(String groupId);
}
