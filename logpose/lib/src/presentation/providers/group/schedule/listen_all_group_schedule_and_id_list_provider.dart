import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/model/group_schedule_and_id_model.dart';

import '../../../controllers/group_schedule/group_schedule_management_controller.dart';

final listenAllGroupScheduleAndIdListProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    final groupScheduleController =
        ref.read(groupScheduleManagementControllerProvider);
    yield* groupScheduleController.listenAllGroupScheduleAndIdList(groupId);
  },
);
