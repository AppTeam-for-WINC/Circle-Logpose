import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_update_helper.dart';
import '../../user/user_controller_provider.dart';
import '../../validator/validator_controller_provider.dart';
import '../schedule/group_member_schedule_controller_provider.dart';
import '../schedule/group_schedule_controller_provider.dart';
import 'group_controller_provider.dart';
import 'group_membership_controller_provider.dart';

final groupUpdateHelperProvider = Provider<GroupUpdateHelper>(
  (ref) {
    final groupRepository = ref.read(groupRepositoryProvider);
    final memberRepository = ref.read(groupMembershipRepositoryProvider);
    final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
    final groupMemberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final validator = ref.read(validatorControllerProvider);

    return GroupUpdateHelper(
      ref: ref,
      groupRepository: groupRepository,
      memberRepository: memberRepository,
      groupScheduleRepository: groupScheduleRepository,
      groupMemberScheduleRepository: groupMemberScheduleRepository,
      userRepository: userRepository,
      validator: validator,
    );
  },
);
