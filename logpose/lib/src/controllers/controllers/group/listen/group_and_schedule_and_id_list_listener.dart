import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/custom/group_profile_and_schedule_and_id_model.dart';
import '../../../../models/database/group/group_membership.dart';
import '../../../../models/database/group/group_profile.dart';
import '../../../../models/database/group/group_schedule.dart';

import '../../../../server/auth/auth_controller.dart';
import '../../../../server/database/group_controller.dart';
import '../../../../server/database/group_membership_controller.dart';
import '../../../../server/database/group_schedule_controller.dart';

// このコードでは、BLoCパターンの構造をしたRxDartを使用している。以下リンクは参考サイトである。
// https://qiita.com/tetsufe/items/521014ddc59f8d1df581

/// Used with sortedGroupAndScheduleAndIdProvider.
class GroupAndScheduleAndIdListListener {
  const GroupAndScheduleAndIdListListener();

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    final userDocId = await _fetchUserDocId();
    if (userDocId == null) {
      throw Exception('User not logged in.');
    }

    await for (final membershipList in _watchAllWithUserId(userDocId)) {
      yield* _aggregateGroupData(membershipList);
    }
  }

  Future<String?> _fetchUserDocId() async {
    try {
      return AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. ${e.message}');
    }
  }

  Stream<List<GroupMembership?>> _watchAllWithUserId(String userDocId) {
    try {
      return GroupMembershipController.watchAllWithUserId(userDocId);
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

      final groupProfile = await _fetchGroupProfile(membership.groupId);
      streams.add(_watchCombinedAllData(membership.groupId, groupProfile));
    }

    return streams;
  }

  Future<GroupProfile> _fetchGroupProfile(String groupId) async {
    try {
      return await GroupController.fetch(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group. ${e.message}');
    }
  }

  Stream<(List<String?>, String, GroupProfile)> _watchCombinedAllData(
    String groupId,
    GroupProfile groupProfile,
  ) async* {
    final stream = _watchAllScheduleId(groupId);

    await for (final List<String?> snapshot in stream) {
      yield (snapshot, groupId, groupProfile);
    }
  }

  Stream<List<String?>> _watchAllScheduleId(String groupId) {
    try {
      return GroupScheduleController.watchAllScheduleId(groupId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to listen all schedule ID. ${e.message}');
    }
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
    try {
      return await GroupScheduleController.fetch(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group schedule. ${e.message}');
    }
  }
}
