import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/database/user/user.dart';
import '../role/group_role_profile_stream_provider.dart';

/// Provides a stream of admin profiles for a specific group ID.
final watchGroupAdminProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final stream =
      ref.read(groupRoleProfileStreamProvider).watchAdminProfile(groupId);
  return stream;
});
