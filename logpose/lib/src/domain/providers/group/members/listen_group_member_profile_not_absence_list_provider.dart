import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/group_membership_facade.dart';

import '../../../entity/user_profile.dart';

final listenGroupMemberProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final memberFacade = ref.read(groupMembershipFacadeProvider);

  yield* memberFacade.listenAllMemberProfileNotAbsenceList(scheduleId);
});
