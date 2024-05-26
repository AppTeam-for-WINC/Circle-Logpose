// ignore_for_file: one_member_abstracts

import '../../entity/user_profile.dart';

abstract class IGroupMemberScheduleDeleteUseCase {
  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  );
}
