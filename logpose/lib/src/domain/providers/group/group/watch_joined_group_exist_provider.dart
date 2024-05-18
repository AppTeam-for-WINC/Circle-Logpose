import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/auth/auth_repository.dart';
import '../../../../data/repository/database/group_membership_repository.dart';

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
