import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_membership_facade.dart';

final memberDeleteControllerProvider = Provider<MemberDeleteController>(
  MemberDeleteController.new,
);

class MemberDeleteController {
  MemberDeleteController(this.ref);
  final Ref ref;

  Future<void> deleteMember(String groupId, String accountId) async {
    final memberFacade = ref.read(groupMembershipFacadeProvider);
    await memberFacade.deleteMemberWithGroupIdAndAccountId(groupId, accountId);
  }
}
