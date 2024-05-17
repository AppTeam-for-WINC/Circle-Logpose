import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/custom/group_schedule_and_id_model.dart';

import '../../../usecase/facade/group_schedule_facade.dart';

import '../../repository/group_schedule_repository_provider.dart';

/// Watch group schedule and schedule ID.
final watchGroupScheduleAndIdProvider =
    StreamProvider.family<List<GroupScheduleAndId?>, String>(
  (ref, groupId) async* {
    try {
      final scheduleFetcher = ref.read(groupScheduleFacadeProvider);
      final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);

      yield* groupScheduleRepository.listenAllScheduleId(groupId).asyncMap(
            (scheduleIdList) async =>
                scheduleFetcher.fetchGroupScheduleAndIdList(scheduleIdList),
          );
    } on Exception catch (e) {
      debugPrint('Failed to fetch group schedules: $e');
      yield [];
    }
  },
);
