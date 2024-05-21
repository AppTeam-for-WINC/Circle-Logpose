// ignore_for_file: one_member_abstracts

import '../../model/group_creator_params_model.dart';

abstract class IGroupCreationUseCase {
  Future<String?> createGroup(GroupCreatorParams groupData);
}
