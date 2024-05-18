import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/group_and_id_model.dart';

import '../../../usecase/facade/group_facade.dart';

final fetchGroupAndIdListProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  final groupController = ref.read(groupFacadeProvider);
  return groupController.fetchGroupAndIdList(groupIdList);
});
