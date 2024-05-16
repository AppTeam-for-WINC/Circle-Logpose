import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom/group_schedule_and_id_model.dart';
import '../../models/custom/schedule_params_model.dart';

import '../../models/database/group/group_schedule.dart';
import '../../models/database/user/user.dart';

import '../providers/group/group/group_schedule_and_id_fetcher_helper_provider.dart';
import '../providers/group/group/group_schedule_creation_helper_provider.dart';
import '../providers/group/group/group_schedule_updater_provider.dart';
import '../providers/group/schedule/group_schedule_controller_provider.dart';

import 'helper/group_schedule_and_id_fetcher_helper.dart';
import 'helper/group_schedule_creation_helper.dart';
import 'helper/group_schedule_delete_helper.dart';
import 'helper/group_schedule_update_helper.dart';

final groupScheduleUseCaseProvider = Provider<GroupScheduleUseCase>(
  (ref) => GroupScheduleUseCase(ref: ref),
);

class GroupScheduleUseCase {
  GroupScheduleUseCase({required this.ref})
      : _groupScheduleCreationHelper =
            ref.read(groupScheduleCreationHelperProvider),
        _groupScheduleAndIdHelper =
            ref.read(groupScheduleAndIdFetcherHelperProvider),
        _groupScheduleUpdateHelper =
            ref.read(groupScheduleUpdateHelperProvider),
        _groupScheduleDeleteHelper =
            ref.read(groupScheduleDeleteHelperProvider);

  final Ref ref;
  final GroupScheduleAndIdFetcherHelper _groupScheduleAndIdHelper;
  final GroupScheduleCreationHelper _groupScheduleCreationHelper;
  final GroupScheduleUpdateHelper _groupScheduleUpdateHelper;
  final GroupScheduleDeleteHelper _groupScheduleDeleteHelper;

  Future<String?> createSchedule(ScheduleParams scheduleViewParams) async {
    return _groupScheduleCreationHelper.createSchedule(scheduleViewParams);
  }

  Future<GroupSchedule> fetchGroupSchedule(String groupScheduleId) async {
    final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
    return scheduleRepository.fetch(groupScheduleId);
  }

  Future<GroupScheduleAndId?> fetchGroupScheduleAndId(String scheduleId) async {
    return _groupScheduleAndIdHelper.fetchGroupScheduleAndId(scheduleId);
  }

  Future<List<String?>> fetchAllGroupScheduleId(String groupId) async {
    final scheduleRepository = ref.read(groupScheduleRepositoryProvider);
    return scheduleRepository.fetchAllScheduleId(groupId);
  }

  Future<List<GroupScheduleAndId?>> fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    return _groupScheduleAndIdHelper
        .fetchGroupScheduleAndIdList(scheduleIdList);
  }

  Future<String?> update(String docId, ScheduleParams scheduleParams) async {
    return _groupScheduleUpdateHelper.update(docId, scheduleParams);
  }

  Future<void> deleteSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    return _groupScheduleDeleteHelper.deleteSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }

  Stream<List<String?>> listenAllScheduleId(String groupId) async* {
    try {
      final groupScheduleRepository = ref.read(groupScheduleRepositoryProvider);
      yield* groupScheduleRepository.listenAllScheduleId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen all schedule ID. ${e.message}');
    }
  }
}
