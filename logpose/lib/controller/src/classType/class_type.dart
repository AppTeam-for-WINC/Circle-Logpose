import '../../../database/group/group/group.dart';
import '../../../database/group/schedule/schedule/schedule.dart';

class GroupProfileWithScheduleWithId {
  GroupProfileWithScheduleWithId({
    required this.groupScheduleId,
    required this.groupSchedule,
    required this.groupId,
    required this.groupProfile,
  });
  final String groupScheduleId;
  final GroupSchedule groupSchedule;
  final String groupId;
  final GroupProfile groupProfile;
}
