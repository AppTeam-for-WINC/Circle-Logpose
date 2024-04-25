import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_membership_controller.dart';

/// Watch user joined list of group's profile.
final watchJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      yield [];
      throw Exception('User not login.');
    }

    yield* GroupMembershipController.watchAllWithUserId(userDocId).map(
      (memberships) => memberships
          .map((member) => member?.groupId)
          .whereType<String>()
          .toList(),
    );
  },
);
