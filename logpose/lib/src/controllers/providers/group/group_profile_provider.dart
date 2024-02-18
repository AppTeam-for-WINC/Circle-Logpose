import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/crud/group_membership_controller.dart';

final watchJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final userDocId = await AuthController.getCurrentUserId();
    if (userDocId == null) {
      throw Exception('User not login.');
    }

    final membershipsStream =
        GroupMembershipController.readAllWithUserId(userDocId);

    await for (final memberships in membershipsStream) {
      yield memberships.map((e) => e?.groupId).whereType<String>().toList();
    }
  },
);
