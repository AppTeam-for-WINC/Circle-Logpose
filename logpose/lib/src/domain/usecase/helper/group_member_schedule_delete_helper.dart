import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/database/user/user.dart';
import '../../providers/group/schedule/group_member_schedule_controller_provider.dart';
import '../group_member_schedule_use_case.dart';
import '../user_use_case.dart';

final groupMemberScheduleDeleteHelperProvider =
    Provider<GroupMemberScheduleDeleteHelper>(
  (ref) => GroupMemberScheduleDeleteHelper(
    ref: ref,
  ),
);

class GroupMemberScheduleDeleteHelper {
  const GroupMemberScheduleDeleteHelper({required this.ref});
  final Ref ref;

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
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to read schedule ID and User ID. ${e.message}',
      );
    }
  }

  Future<String> _attemptToFetchMemberScheduleId(
    String accountId,
    String groupScheduleId,
  ) async {
    final userDocId = await _fetchUserDocId(accountId);
    final memberScheduleUseCase = ref.read(groupMemberScheduleUseCaseProvider);
    return memberScheduleUseCase.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
  }

  Future<String> _fetchUserDocId(String accountId) async {
    final userUseCase = ref.read(userUseCaseProvider);
    return userUseCase.fetchUserDocIdWithAccountId(accountId);
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
