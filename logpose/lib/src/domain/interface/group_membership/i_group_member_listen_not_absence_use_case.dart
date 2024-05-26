// ignore_for_file: one_member_abstracts

import '../../entity/user_profile.dart';

abstract class IGroupMemberListenNotAbsenceUseCase {
    Stream<List<UserProfile?>> listenAllMemberProfileNotAbsenceList(
    String scheduleId,
  );
}
