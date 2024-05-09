import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/database/user/user.dart';
import '../../role/group_role_profile_future_provider.dart';

/// Group membership users controller.
final fetchGroupMembershipProfileListProvider =
    FutureProvider.family<List<UserProfile?>, String>((ref, groupId) {
  return ref
      .read(groupRoleProfileFutureProvider)
      .fetchMembershipProfile(groupId);
});
