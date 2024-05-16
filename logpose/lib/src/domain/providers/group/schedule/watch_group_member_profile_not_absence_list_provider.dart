import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/database/user/user.dart';

import '../../../usecase/group_membership_use_case.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  try {
    final memberController = ref.read(groupMembershipUseCaseProvider);
    final groupId =
        await memberController.fetchGroupIdWithScheduleId(scheduleId);
    final stream = memberController.listenAllMembershipIdList(groupId);

    yield* stream.asyncMap((userIdList) {
      return memberController.fetchUserProfilesNotAbsentList(
        userIdList,
        scheduleId,
      );
    });
  } on FirebaseException catch (e) {
    throw Exception('Error: failed to watch member profile. ${e.message}');
  }
});
