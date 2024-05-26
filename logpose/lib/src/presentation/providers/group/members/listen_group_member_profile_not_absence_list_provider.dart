import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/user_profile.dart';

import '../../../controllers/group_membership/group_membership_management_controller.dart';

final listenGroupMemberProfileNotAbsenceListProvider = StreamProvider.family
    .autoDispose<List<UserProfile?>, String>((ref, scheduleId) async* {
  final membershipController =
      ref.read(groupMembershipManagementControllerProvider);
  yield* membershipController.listenAllMemberProfileNotAbsenceList(scheduleId);
});
