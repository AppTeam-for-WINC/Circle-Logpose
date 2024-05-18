import '../../domain/entity/group_member_schedule.dart';

import '../model/group_member_schedule_model.dart';

class GroupMemberScheduleMapper {
  const GroupMemberScheduleMapper();

  static GroupMemberSchedule toEntity(GroupMemberScheduleModel model) {
    return GroupMemberSchedule(
      scheduleId: model.scheduleId,
      userId: model.userId,
      attendance: model.attendance,
      leaveEarly: model.leaveEarly,
      lateness: model.lateness,
      absence: model.absence,
      startAt: model.startAt,
      endAt: model.endAt,
      updatedAt: model.updatedAt,
      createdAt: model.createdAt,
    );
  }

  static GroupMemberScheduleModel toModel(GroupMemberSchedule entity) {
    return GroupMemberScheduleModel(
      scheduleId: entity.scheduleId,
      userId: entity.userId,
      attendance: entity.attendance,
      leaveEarly: entity.leaveEarly,
      lateness: entity.lateness,
      absence: entity.absence,
      startAt: entity.startAt,
      endAt: entity.endAt,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
    );
  }
}
