import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/group_invitation_facade.dart';

final groupInvitationManagementControllerProvider =
    Provider<GroupInvitationManagementController>(
  GroupInvitationManagementController.new,
);

class GroupInvitationManagementController {
  GroupInvitationManagementController(this.ref);

  final Ref ref;

  Future<String> createAndFetchGroupInvitationLink(String groupId) async {
    final groupInvitationFacade = ref.read(groupInvitationFacadeProvider);
    return groupInvitationFacade.createAndFetchGroupInvitationLink(groupId);
  }
}
