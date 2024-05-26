import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/model/group_and_id_model.dart';

import '../../../controllers/group/group_management_controller.dart';

final listenGroupAndIdProvider =
    StreamProvider.family<GroupAndId?, String>((ref, groupId) {
  final groupController = ref.read(groupManagementControllerProvider);

  return groupController.listenGroupAndId(groupId);
});
