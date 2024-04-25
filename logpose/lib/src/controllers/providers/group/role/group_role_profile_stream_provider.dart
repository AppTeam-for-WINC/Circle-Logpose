import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/role/group_role_profile.dart';

/// Singleton provider for GroupRoleProfileStream.
final groupRoleProfileStreamProvider = Provider<GroupRoleProfileStream>((ref) {
  return GroupRoleProfileStream.instance;
});
