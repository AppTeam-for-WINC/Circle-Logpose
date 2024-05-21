import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/member_schedule_repository.dart';

import '../../interface/group_member_schedule/i_group_member_schedule_creation_use_case.dart';
import '../../interface/group_membership/i_group_member_id_use_case.dart';

import '../usecase_group_membership/group_member_id_use_case.dart';

final groupMemberScheduleCreationUseCaseProvider =
    Provider<IGroupMemberScheduleCreationUseCase>((ref) {
  final memberIdUseCase = ref.read(groupMemberIdUseCaseProvider);

  return GroupMemberScheduleCreationUseCase(
    ref: ref,
    memberIdUseCase: memberIdUseCase,
  );
});

class GroupMemberScheduleCreationUseCase
    implements IGroupMemberScheduleCreationUseCase {
  const GroupMemberScheduleCreationUseCase({
    required this.ref,
    required this.memberIdUseCase,
  });

  final Ref ref;
  final IGroupMemberIdUseCase memberIdUseCase;

  @override
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

  @override
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
    return memberIdUseCase.fetchAllUserDocIdWithGroupId(groupId);
  }
}
