import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/auth/auth_controller.dart';
import '../../../services/database/crud/group_membership_controller.dart';

final checkJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final groupIsExistStream =
      GroupMembershipController.readAllWithUserId(userDocId);

  await for (final groupIsExist in groupIsExistStream) {
    yield groupIsExist.isNotEmpty;
  }
});
