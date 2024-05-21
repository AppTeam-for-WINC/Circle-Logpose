import '../../model/group_and_id_model.dart';

abstract class IGroupAndIdUseCase {
  Future<GroupAndId> fetchGroupAndId(String groupId);

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList);
}
