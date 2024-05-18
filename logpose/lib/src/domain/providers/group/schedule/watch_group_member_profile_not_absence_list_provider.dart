import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entity/user_profile.dart';

import '../../../usecase/facade/group_membership_facade.dart';
import '../../../usecase/facade/group_schedule_facade.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  try {
    final groupFacade = ref.read(groupScheduleFacadeProvider);
    final memberFacade = ref.read(groupMembershipFacadeProvider);
    final groupId = await groupFacade.fetchGroupIdWithScheduleId(scheduleId);
    final stream = memberFacade.listenAllMembershipIdList(groupId);

    yield* stream.asyncMap((userIdList) {
      return memberFacade.fetchUserProfilesNotAbsentList(
        userIdList,
        scheduleId,
      );
    });
  } on FirebaseException catch (e) {
    debugPrint('Error: failed to watch member profile. ${e.message}');
    yield [];
  }
});
