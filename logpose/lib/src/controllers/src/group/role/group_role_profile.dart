import '../../../../models/user/user.dart';
import '../../../../services/database/group_membership_controller.dart';

class GroupRoleProfileStream {
  GroupRoleProfileStream._internal();
  static final GroupRoleProfileStream _instance =
      GroupRoleProfileStream._internal();
  static GroupRoleProfileStream get instance => _instance;

  Stream<List<UserProfile?>> watchAdminProfile(String groupId) async* {
    yield* GroupMembershipController.watchAllUserProfileWithGroupIdAndRole(
      groupId,
      'admin',
    );
  }

  Stream<List<UserProfile?>> watchMembershipProfile(String groupId) async* {
    yield* GroupMembershipController.watchAllUserProfileWithGroupIdAndRole(
      groupId,
      'membership',
    );
  }
}
