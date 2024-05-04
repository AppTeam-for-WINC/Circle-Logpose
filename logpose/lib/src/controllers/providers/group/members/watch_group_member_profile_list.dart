import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/database/user/user.dart';
import '../role/group_role_profile_stream_provider.dart';

/// Provides a stream of member profiles for a specific group ID.
final watchGroupMemberProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final stream =
      ref.read(groupRoleProfileStreamProvider).watchMemberProfile(groupId);
  return stream;
});
