import '../../model/schedule_response_params_model.dart';

abstract class IGroupMemberScheduleUpdateUseCase {
  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt);

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt);

  Future<void> updateResponse(ScheduleResponseParams scheduleParams);
}
