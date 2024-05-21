import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/group_facade.dart';

import '../../../model/group_and_id_model.dart';

final fetchGroupAndIdListProvider =
    FutureProvider.family<List<GroupAndId>, List<String>>(
        (ref, groupIdList) async {
  final groupFacade = ref.read(groupFacadeProvider);
  
  return groupFacade.fetchGroupAndIdList(groupIdList);
});
