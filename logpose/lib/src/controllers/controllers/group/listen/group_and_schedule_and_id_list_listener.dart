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

class GroupAndScheduleAndIdListListener {
  GroupAndScheduleAndIdListListener._internal();
  static final GroupAndScheduleAndIdListListener _instance =
      GroupAndScheduleAndIdListListener._internal();
  static GroupAndScheduleAndIdListListener get instance => _instance;

  static Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    final userDocId = await _fetchUserDocId();
    if (userDocId == null) {
      throw Exception('User not logged in.');
    }

    await for (final membershipList in _watchAllWithUserId(userDocId)) {
      yield* _aggregateGroupData(membershipList);
    }
  }

  static Future<String?> _fetchUserDocId() async {
    try {
      return AuthController.fetchCurrentUserId();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch current user ID. $e');
    }
  }

  static Stream<List<GroupMembership?>> _watchAllWithUserId(String userDocId) {
    return GroupMembershipController.watchAllWithUserId(userDocId);
  }

  static Stream<List<GroupProfileAndScheduleAndId>> _aggregateGroupData(
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

  static Future<List<Stream<(List<String?>, String, GroupProfile)>>>
      _getScheduleStreams(
    List<GroupMembership?> membershipList,
  ) async {
    final streams = <Stream<(List<String?>, String, GroupProfile)>>[];
    for (final membership in membershipList) {
      if (membership == null) {
        continue;
      }

      final groupProfile = await _readGroupProfile(membership.groupId);
      streams.add(_watchAllScheduleId(membership.groupId, groupProfile));
    }

    return streams;
  }

  static Future<GroupProfile> _readGroupProfile(String groupId) async {
    return GroupController.fetch(groupId);
  }

  static Stream<(List<String?>, String, GroupProfile)> _watchAllScheduleId(
    String groupId,
    GroupProfile groupProfile,
  ) async* {
    final stream = GroupScheduleController.watchAllScheduleId(groupId);

    await for (final List<String?> snapshot in stream) {
      yield (snapshot, groupId, groupProfile);
    }
  }

  static Future<List<GroupProfileAndScheduleAndId>> _createCombinedSchedules(
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
          final schedule = await _readGroupSchedule(scheduleId!);
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

  static Future<GroupSchedule?> _readGroupSchedule(String scheduleId) async {
    return GroupScheduleController.fetch(scheduleId);
  }
}
