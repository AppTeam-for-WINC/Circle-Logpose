import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../providers/repository/group_member_schedule_repository_provider.dart';

import '../usecase_user/user_id_use_case.dart';
import 'group_member_schedule_id_use_case.dart';

final groupMemberScheduleDeleteUseCaseProvider =
    Provider<GroupMemberScheduleDeleteUseCase>((ref) {
  final memberScheduleIdUseCase =
      ref.read(groupMemberScheduleIdUseCaseProvider);
  return GroupMemberScheduleDeleteUseCase(
    ref: ref,
    memberScheduleIdUseCase: memberScheduleIdUseCase,
  );
});

class GroupMemberScheduleDeleteUseCase {
  const GroupMemberScheduleDeleteUseCase({
    required this.ref,
    required this.memberScheduleIdUseCase,
  });

  final Ref ref;
  final GroupMemberScheduleIdUseCase memberScheduleIdUseCase;

  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    await Future.wait(
      groupMemberList.map((member) async {
        return _attemptToDeleteAllMemberSchedule(
          member,
          groupScheduleId,
        );
      }),
    );
  }

  Future<void> _attemptToDeleteAllMemberSchedule(
    UserProfile? member,
    String groupScheduleId,
  ) async {
    if (member == null) {
      debugPrint('Member is not existed.');
      return;
    }

    final memberScheduleId = await _fetchMemberScheduleId(
      member.accountId,
      groupScheduleId,
    );
    await _deleteMemberSchedule(memberScheduleId);
  }

  Future<String> _fetchMemberScheduleId(
    String accountId,
    String groupScheduleId,
  ) async {
    try {
      return await _attemptToFetchMemberScheduleId(accountId, groupScheduleId);
    } on Exception catch (e) {
      throw Exception('Error: failed to read schedule ID and User ID. $e');
    }
  }

  Future<String> _attemptToFetchMemberScheduleId(
    String accountId,
    String groupScheduleId,
  ) async {
    final userDocId = await _fetchUserDocId(accountId);
    return memberScheduleIdUseCase.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
  }

  Future<String> _fetchUserDocId(String accountId) async {
    final userIdUseCase = ref.read(userIdUseCaseProvider);
    return userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<void> _deleteMemberSchedule(String memberScheduleId) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await memberScheduleRepository.delete(memberScheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete member schedule. ${e.message}');
    }
  }
}
