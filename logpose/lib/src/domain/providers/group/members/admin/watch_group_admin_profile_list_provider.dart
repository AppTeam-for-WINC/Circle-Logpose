import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../entity/user_profile.dart';
import '../../../../usecase/facade/group_membership_facade.dart';

final watchGroupAdminProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  return ref
      .read(groupMembershipFacadeProvider)
      .listenAllAdminProfile(groupId);
});
