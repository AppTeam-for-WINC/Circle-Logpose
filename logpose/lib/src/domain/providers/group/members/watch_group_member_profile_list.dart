import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entity/user_profile.dart';

import '../../../usecase/facade/group_membership_facade.dart';

final watchGroupMemberProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final memberFacade = ref.read(groupMembershipFacadeProvider);
  final stream = memberFacade.listenAllMember(groupId);
  return stream;
});
