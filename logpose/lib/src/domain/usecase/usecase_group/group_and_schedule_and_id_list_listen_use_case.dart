import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../entity/group_membership.dart';
import '../../entity/group_profile.dart';
import '../../entity/group_schedule.dart';

import '../../model/group_profile_and_schedule_and_id_model.dart';

import '../usecase_group_membership/group_member_listen_use_case.dart';
import '../usecase_group_schedule/group_schedule_listen_id_use_case.dart';
import '../usecase_group_schedule/group_schedule_use_case.dart';
import '../usecase_user/user_id_use_case.dart';
import 'group_use_case.dart';

final groupAndScheduleAndIdListListenUseCaseProvider =
    Provider<GroupAndScheduleAndIdListListenUseCase>((ref) {
  final userIdUseCase = ref.read(userIdUseCaseProvider);
  final groupUseCase = ref.read(groupUseCaseProvider);
  final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);
  final groupScheduleListenIdUseCase =
      ref.read(groupScheduleListenIdUseCaseProvider);
  final memberListenUseCase = ref.read(groupMemberListenUseCaseProvider);

  return GroupAndScheduleAndIdListListenUseCase(
    ref: ref,
    userIdUseCase: userIdUseCase,
    groupUseCase: groupUseCase,
    groupScheduleUseCase: groupScheduleUseCase,
    groupScheduleListenIdUseCase: groupScheduleListenIdUseCase,
    memberListenUseCase: memberListenUseCase,
  );
});

class GroupAndScheduleAndIdListListenUseCase {
  const GroupAndScheduleAndIdListListenUseCase({
    required this.ref,
    required this.userIdUseCase,
    required this.groupUseCase,
    required this.groupScheduleUseCase,
    required this.groupScheduleListenIdUseCase,
    required this.memberListenUseCase,
  });

  final Ref ref;
  final UserIdUseCase userIdUseCase;
  final GroupUseCase groupUseCase;
  final GroupScheduleUseCase groupScheduleUseCase;
  final GroupScheduleListenIdUseCase groupScheduleListenIdUseCase;
  final GroupMemberListenUseCase memberListenUseCase;

  Stream<List<GroupProfileAndScheduleAndId>>
      listenGroupAndScheduleAndIdList() async* {
    final userDocId = await _fetchUserDocId();

    await for (final membershipList in _listenAllMembershipListWithUserId(
      userDocId,
    )) {
      yield* _aggregateGroupData(membershipList);
    }
  }

  Future<String> _fetchUserDocId() async {
    return userIdUseCase.fetchCurrentUserId();
  }

  Stream<List<GroupMembership?>> _listenAllMembershipListWithUserId(
    String userDocId,
  ) {
    try {
      return memberListenUseCase.listenAllMembershipListWithUserId(userDocId);
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
    return groupScheduleListenIdUseCase.listenAllScheduleId(groupId);
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
