import '../../domain/entity/group_invitation.dart';

import '../model/group_invitation_model.dart';

class GroupInvitationMapper {
  const GroupInvitationMapper();

  static GroupInvitation toEntity(GroupInvitationModel model) {
    return GroupInvitation(
      groupId: model.groupId,
      invitationLink: model.invitationLink,
      expiresAt: model.expiresAt,
      createdAt: model.createdAt,
    );
  }

  static GroupInvitationModel toModel(GroupInvitation entity) {
    return GroupInvitationModel(
      groupId: entity.groupId,
      invitationLink: entity.invitationLink,
      expiresAt: entity.expiresAt,
      createdAt: entity.createdAt,
    );
  }
}
