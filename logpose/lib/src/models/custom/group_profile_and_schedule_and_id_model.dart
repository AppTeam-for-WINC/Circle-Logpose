import '../database/group/group_profile.dart';
import '../database/group/group_schedule.dart';

class GroupProfileAndScheduleAndId {
  GroupProfileAndScheduleAndId({
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
