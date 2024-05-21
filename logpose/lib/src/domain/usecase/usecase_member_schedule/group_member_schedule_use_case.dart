import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_member_schedule_repository.dart';

import '../../../data/repository/database/member_schedule_repository.dart';

import '../../entity/group_member_schedule.dart';

import '../../interface/group_member_schedule/i_group_member_schedule_use_case.dart';

final groupMemberScheduleUseCaseProvider =
    Provider<IGroupMemberScheduleUseCase>((ref) {
  final memberScheduleRepository =
      ref.read(groupMemberScheduleRepositoryProvider);
  return GroupMemberScheduleUseCase(
    ref: ref,
    memberScheduleRepository: memberScheduleRepository,
  );
});

class GroupMemberScheduleUseCase implements IGroupMemberScheduleUseCase {
  const GroupMemberScheduleUseCase({
    required this.ref,
    required this.memberScheduleRepository,
  });

  final Ref ref;
  final IGroupMemberScheduleRepository memberScheduleRepository;

  @override
  Future<GroupMemberSchedule> fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    try {
      final memberSchedule =
          await memberScheduleRepository.fetchMemberSchedule(memberScheduleId);
      if (memberSchedule == null) {
        throw Exception('Error: member schedule is not found.');
      }
      return memberSchedule;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule. ${e.message}');
    }
  }

  @override
  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  ) async {
    try {
      return await memberScheduleRepository
          .fetchMemberScheduleWithUserIdAndScheduleId(
        userDocId: userDocId,
        scheduleId: scheduleId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule. ${e.message}');
    }
  }
}
