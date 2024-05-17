import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/member_schedule.dart';

import '../../providers/repository/group_member_schedule_repository_provider.dart';

final groupMemberScheduleUseCaseProvider = Provider<GroupMemberScheduleUseCase>(
  (ref) => GroupMemberScheduleUseCase(ref: ref),
);

class GroupMemberScheduleUseCase {
  const GroupMemberScheduleUseCase({required this.ref});
  final Ref ref;

  Future<GroupMemberSchedule> fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);

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

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  ) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      return memberScheduleRepository
          .fetchMemberScheduleWithUserIdAndScheduleId(
        userDocId: userDocId,
        scheduleId: scheduleId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule. ${e.message}');
    }
  }
}
