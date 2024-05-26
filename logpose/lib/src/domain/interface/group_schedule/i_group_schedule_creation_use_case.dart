// ignore_for_file: one_member_abstracts

import '../../model/schedule_params_model.dart';

abstract class IGroupScheduleCreationUseCase {
  Future<String?> createSchedule(ScheduleParams scheduleViewParams);
}
