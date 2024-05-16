import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_and_id_model.dart';

import '../../../usecase/group_use_case.dart';

final fetchGroupAndIdListProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  final groupController = ref.read(groupUseCaseProvider);
  return groupController.fetchGroupAndIdList(groupIdList);
});
