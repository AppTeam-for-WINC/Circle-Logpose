import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_member_delete_helper.dart';
import '../../user/user_controller_provider.dart';
import '../group/group_membership_controller_provider.dart';

final groupMemberDeleteHelperProvider = Provider<GroupMemberDeleteHelper>(
  (ref) {
    final memberRepository = ref.read(groupMembershipRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    return GroupMemberDeleteHelper(
      memberRepository: memberRepository,
      userRepository: userRepository,
    );
  },
);
