import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/auth_repository_provider.dart';
import '../../repository/group_membership_repository_provider.dart';

/// Watch user joined list of group's profile.
final watchJoinedGroupsProfileProvider = StreamProvider<List<String>>(
  (ref) async* {
    final authRepository = ref.read(authRepositoryProvider);
    final userDocId = await authRepository.fetchCurrentUserId();

    if (userDocId == null) {
      yield [];
      throw Exception('User not login.');
    }

    final memberRepository = ref.read(groupMembershipRepositoryProvider);
    yield* memberRepository.watchAllWithUserId(userDocId).map(
      (memberships) => memberships
          .map((member) => member?.groupId)
          .whereType<String>()
          .toList(),
    );
  },
);
