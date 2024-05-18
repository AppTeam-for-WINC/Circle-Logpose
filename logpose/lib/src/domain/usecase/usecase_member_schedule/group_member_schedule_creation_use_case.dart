import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/member_schedule_repository.dart';

import 'group_member_schedule_id_use_case.dart';

final groupMemberScheduleCreationUseCaseProvider =
    Provider<GroupMemberScheduleCreationUseCase>((ref) {
  final memberScheduleIdUseCase =
      ref.read(groupMemberScheduleIdUseCaseProvider);
      
  return GroupMemberScheduleCreationUseCase(
    ref: ref,
    memberScheduleIdUseCase: memberScheduleIdUseCase,
  );
});

class GroupMemberScheduleCreationUseCase {
  const GroupMemberScheduleCreationUseCase({
    required this.ref,
    required this.memberScheduleIdUseCase,
  });

  final Ref ref;
  final GroupMemberScheduleIdUseCase memberScheduleIdUseCase;

  Future<void> createMemberSchedule(String scheduleId, String userId) async {
    try {
      final groupMemberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await groupMemberScheduleRepository.createMemberSchedule(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedule. ${e.message}');
    }
  }

  Future<void> createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    try {
      await _attemptToCreateAllMemberSchedule(groupId, scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedules. ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error: unexpected error occured. $e');
    }
  }

  Future<void> _attemptToCreateAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    final snapshot = await _fetchAllUserDocIdWithGroupId(groupId);
    await Future.wait(
      snapshot.map((userDocId) async {
        await createMemberSchedule(scheduleId, userDocId);
      }),
    );
  }

  Future<List<String>> _fetchAllUserDocIdWithGroupId(String groupId) async {
    return memberScheduleIdUseCase.fetchAllUserDocIdWithGroupId(groupId);
  }
}
