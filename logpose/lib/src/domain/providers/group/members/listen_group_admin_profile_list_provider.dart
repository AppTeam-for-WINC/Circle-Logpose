import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/group_membership_facade.dart';

import '../../../entity/user_profile.dart';

final listenGroupAdminProfileListProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, groupId) {
  final membberFacade = ref.read(groupMembershipFacadeProvider);
  
  return membberFacade.listenAllAdminProfile(groupId);
});
