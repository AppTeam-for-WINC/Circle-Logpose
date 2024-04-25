import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';
import '../role/group_role_profile_stream_provider.dart';

/// Group membership users controller.
final watchGroupMembershipProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final stream =
      ref.read(groupRoleProfileStreamProvider).watchMembershipProfile(groupId);

  return stream;
});
