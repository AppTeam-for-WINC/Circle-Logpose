import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_membership_repository.dart';
import '../../interface/i_group_membership_repository.dart';

final groupMembershipRepositoryProvider = Provider<IGroupMembershipRepository>(
  (ref) => GroupMembershipRepository(ref: ref),
);
