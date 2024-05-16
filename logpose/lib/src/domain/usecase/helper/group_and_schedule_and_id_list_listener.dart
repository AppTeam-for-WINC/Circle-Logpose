import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../../models/database/group/group_membership.dart';
import '../../../models/database/group/group_profile.dart';
import '../../../models/database/group/group_schedule.dart';

import '../../providers/group/group/group_membership_controller_provider.dart';

import '../auth_use_case.dart';
import '../group_schedule_use_case.dart';
import '../group_use_case.dart';

// このコードでは、BLoCパターンの構造をしたRxDartを使用しています。以下リンクは参考サイトです。
// https://qiita.com/tetsufe/items/521014ddc59f8d1df581

class GroupAndScheduleAndIdListListenHelper {
  const GroupAndScheduleAndIdListListenHelper({
    required this.ref,
    required this.authUseCase,
    required this.groupUseCase,
    required this.groupScheduleUseCase,
  });

  final Ref ref;
  final AuthUseCase authUseCase;
  final GroupUseCase groupUseCase;
  final GroupScheduleUseCase groupScheduleUseCase;

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    final userDocId = await _fetchUserDocId();

    await for (final membershipList in _watchAllWithUserId(userDocId)) {
      yield* _aggregateGroupData(membershipList);
    }
  }

  Future<String> _fetchUserDocId() async {
    return authUseCase.fetchCurrentUserId();
  }

  Stream<List<GroupMembership?>> _watchAllWithUserId(String userDocId) {
    try {
      final memberRepository = ref.read(groupMembershipRepositoryProvider);
      return memberRepository.watchAllWithUserId(userDocId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user ID. ${e.message}');
    }
  }

  Stream<List<GroupProfileAndScheduleAndId>> _aggregateGroupData(
    List<GroupMembership?> membershipList,
  ) async* {
    final streams = await _getScheduleStreams(membershipList);
    final combStream =
        CombineLatestStream.list<(List<String?>, String, GroupProfile)>(
      streams,
    );

    await for (final combList in combStream) {
      yield await _createCombinedSchedules(combList);
    }
  }

  Future<List<Stream<(List<String?>, String, GroupProfile)>>>
      _getScheduleStreams(
    List<GroupMembership?> membershipList,
  ) async {
    final streams = <Stream<(List<String?>, String, GroupProfile)>>[];
    for (final membership in membershipList) {
      if (membership == null) {
        continue;
      }

      final groupProfile = await _fetchGroup(membership.groupId);
      streams.add(_watchCombinedAllData(membership.groupId, groupProfile));
    }

    return streams;
  }

  Future<GroupProfile> _fetchGroup(String groupId) async {
    return groupUseCase.fetchGroup(groupId);
  }

  Stream<(List<String?>, String, GroupProfile)> _watchCombinedAllData(
    String groupId,
    GroupProfile groupProfile,
  ) async* {
    final stream = _listenAllScheduleId(groupId);

    await for (final List<String?> snapshot in stream) {
      yield (snapshot, groupId, groupProfile);
    }
  }

  Stream<List<String?>> _listenAllScheduleId(String groupId) {
    return groupScheduleUseCase.listenAllScheduleId(groupId);
  }

  Future<List<GroupProfileAndScheduleAndId>> _createCombinedSchedules(
    List<(List<String?>, String, GroupProfile)> combList,
  ) async {
    final combinedSchedules = <GroupProfileAndScheduleAndId>[];

    await Future.wait(
      /// <()> is named 'Record type' or 'Turple type'.
      /// To access element by $index.
      /// Example $1 is [0].
      ///
      combList.expand((record) {
        final scheduleIdList = record.$1;
        final groupId = record.$2;
        final groupProfile = record.$3;

        return scheduleIdList.where((id) => id != null).map((scheduleId) async {
          final schedule = await _fetchGroupSchedule(scheduleId!);
          if (schedule != null) {
            combinedSchedules.add(
              GroupProfileAndScheduleAndId(
                groupScheduleId: scheduleId,
                groupSchedule: schedule,
                groupId: groupId,
                groupProfile: groupProfile,
              ),
            );
          }
        });
      }).toList(),
    );

    return combinedSchedules;
  }

  Future<GroupSchedule?> _fetchGroupSchedule(String scheduleId) async {
    return groupScheduleUseCase.fetchGroupSchedule(scheduleId);
  }
}
