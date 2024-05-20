import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../usecase_group_invitation/group_invitation_use_case.dart';

final groupInvitationFacadeProvider = Provider<GroupInvitationFacade>(
  (ref) => GroupInvitationFacade(ref: ref),
);

class GroupInvitationFacade {
  GroupInvitationFacade({required this.ref})
      : _groupInvitationUseCase = ref.read(groupInvitationUseCaseProvider);

  final Ref ref;
  final GroupInvitationUseCase _groupInvitationUseCase;

  Future<String> createAndFetchGroupInvitationLink(String groupId) async {
    return _groupInvitationUseCase.createAndFetchGroupInvitationLink(groupId);
  }
}
