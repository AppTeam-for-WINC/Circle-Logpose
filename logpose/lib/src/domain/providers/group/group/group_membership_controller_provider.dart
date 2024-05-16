import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/group_membership_repository.dart';

final groupMembershipRepositoryProvider = Provider<GroupMembershipRepository>(
  (ref) => GroupMembershipRepository.instance,
);
