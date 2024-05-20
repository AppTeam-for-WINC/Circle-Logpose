import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entity/user_profile.dart';

import '../usecase_group_schedule/group_id_with_schedule_id_use_case.dart';
import 'group_member_id_listen_use_case.dart';
import 'group_member_use_case.dart';

final groupMemberListenNotAbsenceUseCaseProvider =
    Provider<GroupMemberListenNotAbsenceUseCase>((ref) {
  final groupIdWithScheduleIdUseCase =
      ref.read(groupIdWithScheduleIdUseCaseProvider);
  final memberUseCase = ref.read(groupMemberUseCaseProvider);
  final memberIdListenUseCase = ref.read(groupMemberIdListenUseCaseProvider);

  return GroupMemberListenNotAbsenceUseCase(
    ref: ref,
    groupIdWithScheduleIdUseCase: groupIdWithScheduleIdUseCase,
    memberUseCase: memberUseCase,
    memberIdListenUseCase: memberIdListenUseCase,
  );
});

class GroupMemberListenNotAbsenceUseCase {
  const GroupMemberListenNotAbsenceUseCase({
    required this.ref,
    required this.groupIdWithScheduleIdUseCase,
    required this.memberIdListenUseCase,
    required this.memberUseCase,
  });

  final Ref ref;
  final GroupIdWithScheduleIdUseCase groupIdWithScheduleIdUseCase;
  final GroupMemberUseCase memberUseCase;
  final GroupMemberIdListenUseCase memberIdListenUseCase;

  Stream<List<UserProfile?>> listenAllMemberProfileNotAbsenceList(
    String scheduleId,
  ) async* {
    try {
      yield* _attemptToListen(scheduleId);
    } on FirebaseException catch (e) {
      debugPrint('Error: failed to watch member profile. ${e.message}');
      yield [];
    }
  }

  Stream<List<UserProfile?>> _attemptToListen(String scheduleId) async* {
    final groupId = await _fetchGroupId(scheduleId);
    final stream = _listenAllMembershipIdList(groupId);

    yield* stream.asyncMap((membershipIdList) {
      return _fetchUserProfilesNotAbsentList(membershipIdList, scheduleId);
    });
  }

  Future<String> _fetchGroupId(String scheduleId) async {
    return groupIdWithScheduleIdUseCase.fetchGroupIdWithScheduleId(scheduleId);
  }

  Stream<List<String?>> _listenAllMembershipIdList(String groupId) {
    return memberIdListenUseCase.listenAllMembershipIdList(groupId);
  }

  Future<List<UserProfile?>> _fetchUserProfilesNotAbsentList(
    List<String?> membershipIdList,
    String scheduleId,
  ) async {
    return memberUseCase.fetchUserProfilesNotAbsentList(
      membershipIdList,
      scheduleId,
    );
  }
}
