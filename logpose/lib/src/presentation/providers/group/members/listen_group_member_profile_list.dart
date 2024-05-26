import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/user_profile.dart';

import '../../../controllers/group_membership/group_membership_management_controller.dart';

final listenGroupMemberProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final membershipController =
      ref.read(groupMembershipManagementControllerProvider);
  return membershipController.listenAllMember(groupId);
});
