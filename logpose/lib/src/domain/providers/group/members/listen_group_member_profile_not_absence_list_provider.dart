import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entity/user_profile.dart';

import '../../../usecase/facade/group_membership_facade.dart';

final listenGroupMemberProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final memberFacade = ref.read(groupMembershipFacadeProvider);

  yield* memberFacade.listenAllMemberProfileNotAbsenceList(scheduleId);
});
