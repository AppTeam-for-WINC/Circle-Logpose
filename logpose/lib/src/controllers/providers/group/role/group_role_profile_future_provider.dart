import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/role/group_role_profile_future.dart';

/// Singleton provider for GroupRoleProfileFuture.
final groupRoleProfileFutureProvider = Provider<GroupRoleProfileFuture>((ref) {
  return GroupRoleProfileFuture.instance;
});
