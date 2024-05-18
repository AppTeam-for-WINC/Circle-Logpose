import '../../domain/entity/group_membership.dart';

import '../model/group_membership_model.dart';

class GroupMembershipMapper {
  const GroupMembershipMapper();

  static GroupMembership toEntity(GroupMembershipModel model) {
    return GroupMembership(
      userId: model.userId,
      username: model.username,
      userDescription: model.userDescription,
      role: model.role,
      groupId: model.groupId,
      updatedAt: model.updatedAt,
      joinedAt: model.joinedAt,
    );
  }

  static GroupMembershipModel toModel(GroupMembership entity) {
    return GroupMembershipModel(
      userId: entity.userId,
      username: entity.username,
      userDescription: entity.userDescription,
      role: entity.role,
      groupId: entity.groupId,
      updatedAt: entity.updatedAt,
      joinedAt: entity.joinedAt,
    );
  }
}
