import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/auth/auth_management_controller.dart';
import '../../../controllers/group_membership/group_membership_management_controller.dart';

final listenIsJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final authController = ref.read(authManagementControllerProvider);
  final userId = await authController.fetchCurrentUserId();
  final membershipController =
      ref.read(groupMembershipManagementControllerProvider);
  final stream = membershipController.listenAllMembershipListWithUserId(userId);

  yield* stream.map((membershipList) => membershipList.isNotEmpty);
});
