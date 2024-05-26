import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_facade.dart';

import '../../domain/model/group_and_id_model.dart';

final groupAndIdListControllerProvider = Provider<GroupAndIdListController>(
  GroupAndIdListController.new,
);

class GroupAndIdListController {
  GroupAndIdListController(this.ref);
  final Ref ref;

  Future<List<GroupAndId>> fetchGroupAndIdList(List<String> groupIdList) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.fetchGroupAndIdList(groupIdList);
  }
}
