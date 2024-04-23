import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user/user.dart';

import '../../../../services/database/group_membership_controller.dart';

import '../../../src/group/fetch/group_member_profile_fetcher.dart';

/// Group membership user list controller under condition not absence.
final watchGroupMembershipProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final groupId =
      await GroupMemberProfileFetcher.fetchGroupIdWithScheduleId(scheduleId);

  yield* GroupMembershipController.watchAllUserDocIdWithGroupId(groupId)
      .asyncMap(
    (userIdList) => GroupMemberProfileFetcher.fetchUserProfilesNotAbsentList(
      scheduleId,
      userIdList,
    ),
  );
});
