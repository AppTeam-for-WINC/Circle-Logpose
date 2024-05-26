import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/model/group_and_id_model.dart';

import '../../../controllers/group/group_management_controller.dart';

final fetchGroupAndIdListProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  final groupController = ref.read(groupManagementControllerProvider);
  
  return groupController.fetchGroupAndIdList(groupIdList);
});
