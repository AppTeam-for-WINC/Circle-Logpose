import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/auth/auth_controller.dart';
import '../../../../services/database/group_membership_controller.dart';

final watchJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final groupIsExistStream =
      GroupMembershipController.watchAllWithUserId(userDocId);

  await for (final groupIsExist in groupIsExistStream) {
    yield groupIsExist.isNotEmpty;
  }
});
