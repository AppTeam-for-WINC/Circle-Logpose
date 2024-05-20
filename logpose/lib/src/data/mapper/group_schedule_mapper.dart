import '../../domain/entity/group_schedule.dart';

import '../model/group_schedule_model.dart';

class GroupScheduleMapper {
  const GroupScheduleMapper();

  static GroupSchedule toEntity(GroupScheduleModel model) {
    return GroupSchedule(
      groupId: model.groupId,
      title: model.title,
      color: model.color,
      place: model.place,
      detail: model.detail,
      startAt: model.startAt,
      endAt: model.endAt,
      updatedAt: model.updatedAt,
      createdAt: model.createdAt,
    );
  }

  static GroupScheduleModel toModel(GroupSchedule entity) {
    return GroupScheduleModel(
      groupId: entity.groupId,
      title: entity.title,
      color: entity.color,
      place: entity.place,
      detail: entity.detail,
      startAt: entity.startAt,
      endAt: entity.endAt,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
    );
  }
}
