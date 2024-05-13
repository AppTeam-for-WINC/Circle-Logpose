import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/role/group_role_profile_listener.dart';

/// Singleton provider for GroupRoleProfileStream.
final groupRoleProfileStreamListenerProvider =
    Provider<GroupRoleProfileListener>((ref) {
  return const GroupRoleProfileListener();
});
