import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/user.dart';

import '../../../../usecase/facade/group_membership_facade.dart';

final watchGroupMembershipProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  return ref
      .read(groupMembershipFacadeProvider)
      .listenAllMembershipProfile(groupId);
});
