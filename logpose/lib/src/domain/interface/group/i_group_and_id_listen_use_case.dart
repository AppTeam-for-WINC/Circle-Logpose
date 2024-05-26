// ignore_for_file: one_member_abstracts

import '../../model/group_and_id_model.dart';

abstract class IGroupAndIdListenUseCase {
  Stream<GroupAndId?> listenGroupAndId(String groupId);
}
