import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_facade.dart';

import '../../domain/model/group_setting_params_model.dart';

final groupSettingUpdaterControllerProvider =
    Provider<GroupSettingUpdaterController>(
  GroupSettingUpdaterController.new,
);

class GroupSettingUpdaterController {
  GroupSettingUpdaterController(this.ref);
  final Ref ref;

  Future<String?> updateGroup(GroupSettingParams groupData) async {
    final groupFacade = ref.read(groupFacadeProvider);
    return groupFacade.updateGroup(groupData);
  }
}
