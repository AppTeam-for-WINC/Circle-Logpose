// ignore_for_file: one_member_abstracts

import '../../model/schedule_params_model.dart';

abstract class IGroupScheduleUpdateUseCase {
  Future<String?> update(String docId, ScheduleParams scheduleParams);
}
