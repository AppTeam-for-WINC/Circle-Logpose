import 'database/group.dart';

class GroupWithId {
  GroupWithId({required this.groupProfile, required this.groupId});
  final GroupProfile groupProfile;
  final String groupId;
}
