import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';
import '../../../server/auth/auth_controller.dart';
import '../../../server/database/user_controller.dart';

/// Fetch user profile.
final fetchUserProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userDocId = await _fetchUserDocId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  return UserController.read(userDocId);
});

Future<String?> _fetchUserDocId() async {
  try {
    return AuthController.fetchCurrentUserId();
  } on FirebaseException catch (e) {
    throw Exception('Error: failed to fetch current user ID. $e');
  }
}
