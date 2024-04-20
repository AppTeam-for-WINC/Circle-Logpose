import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_membership_controller.dart';

/// Watch bool whether group is exist or not.
final watchJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    yield false;
    throw Exception('User not logged in.');
  }
  yield* GroupMembershipController.watchAllWithUserId(userDocId).map(
    (groupIsExist) => groupIsExist.isNotEmpty,
  );
});
