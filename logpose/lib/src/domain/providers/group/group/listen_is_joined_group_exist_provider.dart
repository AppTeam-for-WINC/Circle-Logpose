import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/facade/group_membership_facade.dart';
import '../../../usecase/facade/user_service_facade.dart';

final listenIsJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userFacade = ref.read(userServiceFacadeProvider);
  final userId = await userFacade.fetchCurrentUserId();
  final memberFacade = ref.read(groupMembershipFacadeProvider);
  final stream = memberFacade.listenAllMembershipListWithUserId(userId);

  yield* stream.map((membershipList) => membershipList.isNotEmpty);
});
