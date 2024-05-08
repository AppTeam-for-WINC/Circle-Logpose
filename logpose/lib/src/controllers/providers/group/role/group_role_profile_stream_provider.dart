import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/role/group_role_profile_stream.dart';

/// Singleton provider for GroupRoleProfileStream.
final groupRoleProfileStreamProvider = Provider<GroupRoleProfileStream>((ref) {
  return GroupRoleProfileStream.instance;
});
