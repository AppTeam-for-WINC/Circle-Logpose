import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_and_schedule_and_id_list_listener.dart';

import '../../../usecase/auth_use_case.dart';
import '../../../usecase/group_schedule_use_case.dart';
import '../../../usecase/group_use_case.dart';

final groupAndScheduleAndIdListListenHelperProvider =
    Provider<GroupAndScheduleAndIdListListenHelper>((ref) {
  final authUseCase = ref.read(authUseCaseProvider);
  final groupUseCase = ref.read(groupUseCaseProvider);
  final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);

  return GroupAndScheduleAndIdListListenHelper(
    ref: ref,
    authUseCase: authUseCase,
    groupUseCase: groupUseCase,
    groupScheduleUseCase: groupScheduleUseCase,
  );
});
