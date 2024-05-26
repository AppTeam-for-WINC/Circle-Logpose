// ignore_for_file: one_member_abstracts

import '../../entity/user_profile.dart';

abstract class IGroupMemberUseCase {
  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> membershipIdList,
    String scheduleId,
  );
}
