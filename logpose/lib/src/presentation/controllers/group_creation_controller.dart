import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_facade.dart';
import '../../domain/model/group_creator_params_model.dart';

final groupCreationControllerProvider = Provider<GroupCreationController>(
  GroupCreationController.new,
);

class GroupCreationController {
  GroupCreationController(this.ref);

  final Ref ref;

  Future<String?> createGroup(GroupCreatorParams groupData) async {
    try {
      final groupFacade = ref.read(groupFacadeProvider);
      return groupFacade.createGroup(groupData);
    } on Exception catch (e) {
      return 'Error: failed to create group. $e';
    }
  }
}
