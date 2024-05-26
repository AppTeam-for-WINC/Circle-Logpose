import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_schedule_facade.dart';
import '../../domain/model/schedule_params_model.dart';

final groupScheduleControllerProvider = Provider<GroupScheduleController>(
  GroupScheduleController.new,
);

class GroupScheduleController {
  const GroupScheduleController(this.ref);

  final Ref ref;

  Future<String?> createSchedule(ScheduleParams scheduleData) async {
    final scheduleFacade = ref.read(groupScheduleFacadeProvider);
    return scheduleFacade.createSchedule(scheduleData);
  }

  Future<String?> updateSchedule(
    String groupScheduleId,
    ScheduleParams scheduleData,
  ) async {
    final groupScheduleFacade = ref.read(groupScheduleFacadeProvider);
    return groupScheduleFacade.update(groupScheduleId, scheduleData);
  }
}
