import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_schedule_facade.dart';

import '../../../domain/model/schedule_params_model.dart';

final groupScheduleCreationAndUpdateControllerProvider =
    Provider<GroupScheduleCreationAndUpdateController>(
  GroupScheduleCreationAndUpdateController.new,
);

class GroupScheduleCreationAndUpdateController {
  GroupScheduleCreationAndUpdateController(this.ref);

  final Ref ref;

  Future<String?> createSchedule(ScheduleParams scheduleViewParams) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.createSchedule(scheduleViewParams);
  }

  Future<String?> updateSchedule(
    String docId,
    ScheduleParams scheduleParams,
  ) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.updateSchedule(docId, scheduleParams);
  }
}
