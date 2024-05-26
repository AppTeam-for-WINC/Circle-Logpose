import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../interface/group_schedule/i_group_schedule_and_id_list_listen_use_case.dart';
import '../../interface/group_schedule/i_group_schedule_and_id_use_case.dart';

import '../../interface/group_schedule/i_group_schedule_listen_id_use_case.dart';
import '../../model/group_schedule_and_id_model.dart';

import 'group_schedule_and_id_use_case.dart';
import 'group_schedule_listen_id_use_case.dart';

final groupScheduleAndIdListListenUseCaseProvider =
    Provider<IGroupScheduleAndIdListListenUseCase>((ref) {
  final groupScheduleAndIdUseCase = ref.read(groupScheduleAndIdUseCaseProvider);
  final groupScheduleListenIdUseCase =
      ref.read(groupScheduleListenIdUseCaseProvider);

  return GroupScheduleAndIdListListenUseCase(
    groupScheduleAndIdUseCase: groupScheduleAndIdUseCase,
    groupScheduleListenIdUseCase: groupScheduleListenIdUseCase,
  );
});

class GroupScheduleAndIdListListenUseCase
    implements IGroupScheduleAndIdListListenUseCase {
  const GroupScheduleAndIdListListenUseCase({
    required this.groupScheduleAndIdUseCase,
    required this.groupScheduleListenIdUseCase,
  });

  final IGroupScheduleAndIdUseCase groupScheduleAndIdUseCase;
  final IGroupScheduleListenIdUseCase groupScheduleListenIdUseCase;

  @override
  Stream<List<GroupScheduleAndId?>> listenAllGroupScheduleAndIdList(
    String groupId,
  ) async* {
    try {
      yield* _attemptToListen(groupId);
    } on Exception catch (e) {
      debugPrint('Failed to fetch group schedules: $e');
      yield [];
    }
  }

  Stream<List<GroupScheduleAndId?>> _attemptToListen(
    String groupId,
  ) {
    final stream = _listenAllScheduleId(groupId);
    return stream.asyncMap(
      (scheduleIdList) async => _fetchGroupScheduleAndIdList(scheduleIdList),
    );
  }

  Stream<List<String?>> _listenAllScheduleId(String groupId) {
    return groupScheduleListenIdUseCase.listenAllScheduleId(groupId);
  }

  Future<List<GroupScheduleAndId?>> _fetchGroupScheduleAndIdList(
    List<String?> scheduleIdList,
  ) async {
    return groupScheduleAndIdUseCase
        .fetchGroupScheduleAndIdList(scheduleIdList);
  }
}
