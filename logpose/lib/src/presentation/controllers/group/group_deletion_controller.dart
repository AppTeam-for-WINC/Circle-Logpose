import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_facade.dart';

import '../../../domain/model/group_id_and_schedule_id_and_member_list_model.dart';

final groupDeletionControllerProvider = Provider<GroupDeletionController>(
  GroupDeletionController.new,
);

class GroupDeletionController {
  GroupDeletionController(this.ref);

  final Ref ref;

  Future<void> deleteGroup(GroupIdAndScheduleIdAndMemberList groupData) async {
    final groupFacade = ref.read(groupFacadeProvider);
    await groupFacade.deleteGroup(groupData);
  }
}
