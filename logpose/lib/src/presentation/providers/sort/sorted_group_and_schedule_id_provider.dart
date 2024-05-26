import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/group_profile_and_schedule_and_id_model.dart';

import '../../controllers/group/group_management_controller.dart';

import 'sort_option_provider.dart';

final sortedGroupAndScheduleAndIdProvider =
    StreamProvider<List<GroupProfileAndScheduleAndId>>((ref) async* {
  final groupManagementController =
      ref.watch(groupManagementControllerProvider);
  final sortOption = ref.watch(sortOptionProvider);

  yield* groupManagementController.sortedGroupAndScheduleStream(sortOption);
});
