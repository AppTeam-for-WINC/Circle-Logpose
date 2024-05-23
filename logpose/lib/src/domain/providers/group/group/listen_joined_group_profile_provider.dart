import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/auth_facade.dart';
import '../../../../app/facade/group_membership_facade.dart';

final listenJoinedGroupIdListProvider = StreamProvider<List<String>>(
  (ref) async* {
  final authFacade = ref.read(authFacadeProvider);
  final userId = await authFacade.fetchCurrentUserId();
    final memberFacade = ref.read(groupMembershipFacadeProvider);
    final stream = memberFacade.listenAllMembershipListWithUserId(userId);

    yield* stream.map(
      (membershipList) => membershipList
          .map((member) => member?.groupId)
          .whereType<String>()
          .toList(),
    );
  },
);
