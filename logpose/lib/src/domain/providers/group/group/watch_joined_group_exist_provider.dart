import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/auth_repository_provider.dart';
import '../../repository/group_membership_repository_provider.dart';

/// Watch bool whether group is exist or not.
final watchJoinedGroupExistProvider = StreamProvider<bool>((ref) async* {
  final authRepository = ref.read(authRepositoryProvider);
  final userDocId = await authRepository.fetchCurrentUserId();

  if (userDocId == null) {
    yield false;
    throw Exception('User not logged in.');
  }
  
  final memberRepository = ref.read(groupMembershipRepositoryProvider);
  yield* memberRepository.watchAllWithUserId(userDocId).map(
    (groupIsExist) => groupIsExist.isNotEmpty,
  );
});
