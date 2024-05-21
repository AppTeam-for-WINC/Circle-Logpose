import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_member_schedule_repository.dart';

import '../../../data/repository/database/member_schedule_repository.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_id_use_case.dart';

final groupMemberScheduleIdUseCaseProvider =
    Provider<IGroupMemberScheduleIdUseCase>((ref) {
  final memberScheduleRepository =
      ref.read(groupMemberScheduleRepositoryProvider);
  return GroupMemberScheduleIdUseCase(
    ref: ref,
    memberScheduleRepository: memberScheduleRepository,
  );
});

class GroupMemberScheduleIdUseCase implements IGroupMemberScheduleIdUseCase {
  const GroupMemberScheduleIdUseCase({
    required this.ref,
    required this.memberScheduleRepository,
  });

  final Ref ref;
  final IGroupMemberScheduleRepository memberScheduleRepository;

  @override
  Future<String> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    try {
      return await memberScheduleRepository.fetchDocIdWithScheduleIdAndUserId(
        scheduleId: groupScheduleId,
        userDocId: userDocId,
      );
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule ID. ${e.message}',
      );
    }
  }

  @override
  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userId,
  ) async {
    try {
      return await memberScheduleRepository
          .fetchUserIdWithScheduleIdAndUserIdByTerm(
        scheduleId,
        userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }
}
