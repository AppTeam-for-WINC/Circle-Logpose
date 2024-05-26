import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_facade.dart';

import '../../../domain/model/group_creator_params_model.dart';
import '../../../domain/model/group_setting_params_model.dart';

final groupCreationAndUpdateControllerProvider =
    Provider<GroupCreationAndUpdateController>(
  GroupCreationAndUpdateController.new,
);

class GroupCreationAndUpdateController {
  GroupCreationAndUpdateController(this.ref);

  final Ref ref;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.createGroup(groupData);
  }

  Future<String?> updateGroup(GroupSettingParams groupData) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.updateGroup(groupData);
  }
}
