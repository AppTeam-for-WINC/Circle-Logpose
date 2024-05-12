import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../server/auth/auth_controller.dart';
import '../../../../server/database/group_membership_controller.dart';

/// Watch bool whether group is exist or not.
final watchJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await _fetchUserDocId();
  if (userDocId == null) {
    yield false;
    throw Exception('User not logged in.');
  }
  yield* GroupMembershipController.watchAllWithUserId(userDocId).map(
    (groupIsExist) => groupIsExist.isNotEmpty,
  );
});

Future<String?> _fetchUserDocId() async {
  try {
    return AuthController.fetchCurrentUserId();
  } on FirebaseException catch (e) {
    throw Exception('Error: failed to fetch current user ID. $e');
  }
}
