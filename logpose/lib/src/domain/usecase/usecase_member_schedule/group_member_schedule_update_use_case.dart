import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom/schedule_response_params_model.dart';
import '../../providers/repository/group_member_schedule_repository_provider.dart';

final groupMemberScheduleUpdateUseCaseProvider =
    Provider<GroupMemberScheduleUpdateUseCase>(
  (ref) => GroupMemberScheduleUpdateUseCase(ref: ref),
);

class GroupMemberScheduleUpdateUseCase {
  const GroupMemberScheduleUpdateUseCase({required this.ref});

  final Ref ref;

  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await memberScheduleRepository.update(
        docId: memberScheduleId,
        startAt: startAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update StartAt. ${e.message}');
    }
  }

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await memberScheduleRepository.update(
        docId: memberScheduleId,
        endAt: endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update EndAt. ${e.message}');
    }
  }

  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    try {
      final memberScheduleRepository =
          ref.read(groupMemberScheduleRepositoryProvider);
      await memberScheduleRepository.update(
        docId: scheduleParams.memberScheduleId,
        attendance: scheduleParams.attendance,
        leaveEarly: scheduleParams.leaveEarly,
        lateness: scheduleParams.lateness,
        absence: scheduleParams.absence,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update response. ${e.message}');
    }
  }
}
