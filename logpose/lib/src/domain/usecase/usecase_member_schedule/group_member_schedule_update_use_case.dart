import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/interface/i_group_member_schedule_repository.dart';
import '../../../data/repository/database/member_schedule_repository.dart';

import '../../interface/group_member_schedule/i_group_member_schedule_update_use_case.dart';
import '../../model/schedule_response_params_model.dart';

final groupMemberScheduleUpdateUseCaseProvider =
    Provider<IGroupMemberScheduleUpdateUseCase>((ref) {
  final memberScheduleRepository =
      ref.read(groupMemberScheduleRepositoryProvider);
  return GroupMemberScheduleUpdateUseCase(
    ref: ref,
    memberScheduleRepository: memberScheduleRepository,
  );
});

class GroupMemberScheduleUpdateUseCase
    implements IGroupMemberScheduleUpdateUseCase {
  const GroupMemberScheduleUpdateUseCase({
    required this.ref,
    required this.memberScheduleRepository,
  });

  final Ref ref;
  final IGroupMemberScheduleRepository memberScheduleRepository;

  @override
  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    try {
      await memberScheduleRepository.update(
        docId: memberScheduleId,
        startAt: startAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update StartAt. ${e.message}');
    }
  }

  @override
  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    try {
      await memberScheduleRepository.update(
        docId: memberScheduleId,
        endAt: endAt,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update EndAt. ${e.message}');
    }
  }

  @override
  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    try {
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
