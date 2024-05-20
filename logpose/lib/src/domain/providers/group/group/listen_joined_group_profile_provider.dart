import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/facade/group_membership_facade.dart';
import '../../../usecase/facade/user_service_facade.dart';

final listenJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final userFacade = ref.read(userServiceFacadeProvider);
    final userId = await userFacade.fetchCurrentUserId();
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
