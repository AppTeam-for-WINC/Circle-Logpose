// ignore_for_file: one_member_abstracts

import '../../entity/group_profile.dart';

abstract class IGroupUseCase {
  Future<GroupProfile> fetchGroup(String groupId);
}
