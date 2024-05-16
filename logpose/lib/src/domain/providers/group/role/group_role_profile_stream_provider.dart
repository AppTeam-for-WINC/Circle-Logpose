import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_role_profile_listen_helper.dart';

final groupRoleProfileListenHelperProvider =
    Provider<GroupRoleProfileListenHelper>((ref) {
  return GroupRoleProfileListenHelper(ref: ref);
});
