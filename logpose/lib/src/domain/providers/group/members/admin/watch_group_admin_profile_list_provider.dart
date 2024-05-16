import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/database/user/user.dart';
import '../../../../usecase/group_membership_use_case.dart';

final watchGroupAdminProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  return ref
      .read(groupMembershipUseCaseProvider)
      .listenAllAdminProfile(groupId);
});
