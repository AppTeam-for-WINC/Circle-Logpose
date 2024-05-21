// ignore_for_file: one_member_abstracts

import '../../entity/user_profile.dart';

abstract class IGroupScheduleDeleteUseCase {
  Future<void> deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  );
}
