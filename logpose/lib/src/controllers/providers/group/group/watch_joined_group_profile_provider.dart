import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../server/auth/auth_controller.dart';
import '../../../../server/database/group_membership_controller.dart';

/// Watch user joined list of group's profile.
final watchJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final userDocId = await _fetchUserDocId();
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

Future<String?> _fetchUserDocId() async {
  try {
    return AuthController.fetchCurrentUserId();
  } on FirebaseException catch (e) {
    throw Exception('Error: failed to fetch current user ID. $e');
  }
}
