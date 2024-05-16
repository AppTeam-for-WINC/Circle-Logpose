import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom/schedule_response_params_model.dart';
import '../../models/database/group/member_schedule.dart';
import '../../models/database/user/user.dart';

import '../providers/group/group/group_member_schedule_creation_helper_provider.dart';
import '../providers/group/schedule/group_member_schedule_controller_provider.dart';

import 'helper/group_member_schedule_creation_helper.dart';
import 'helper/group_member_schedule_delete_helper.dart';

final groupMemberScheduleUseCaseProvider = Provider<GroupMemberScheduleUseCase>(
  (ref) => GroupMemberScheduleUseCase(ref: ref),
);

class GroupMemberScheduleUseCase {
  GroupMemberScheduleUseCase({required this.ref})
      : _groupMemberScheduleCreationHelper =
            ref.read(groupMemberScheduleCreationHelperProvider),
        _groupMemberScheduleDeleteHelper =
            ref.read(groupMemberScheduleDeleteHelperProvider);

  final Ref ref;
  final GroupMemberScheduleCreationHelper _groupMemberScheduleCreationHelper;
  final GroupMemberScheduleDeleteHelper _groupMemberScheduleDeleteHelper;

  Future<void> createMemberSchedule(String scheduleId, String userId) async {
    await _groupMemberScheduleCreationHelper.createMemberSchedule(
      scheduleId,
      userId,
    );
  }

  Future<void> createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    await _groupMemberScheduleCreationHelper.createAllMemberSchedule(
      groupId,
      scheduleId,
    );
  }

  Future<String> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);

    return memberScheduleRepository.fetchDocIdWithScheduleIdAndUserId(
      scheduleId: groupScheduleId,
      userDocId: userDocId,
    );
  }

  Future<GroupMemberSchedule> fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);

    final memberSchedule =
        await memberScheduleRepository.fetchMemberSchedule(memberScheduleId);
    if (memberSchedule == null) {
      throw Exception('Error: member schedule is not found.');
    }
    return memberSchedule;
  }

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  ) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);
    return memberScheduleRepository.fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId: userDocId,
      scheduleId: scheduleId,
    );
  }

  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);
    await memberScheduleRepository.update(
      docId: memberScheduleId,
      startAt: startAt,
    );
  }

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);
    await memberScheduleRepository.update(
      docId: memberScheduleId,
      endAt: endAt,
    );
  }

  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    final memberScheduleRepository =
        ref.read(groupMemberScheduleRepositoryProvider);
    await memberScheduleRepository.update(
      docId: scheduleParams.memberScheduleId,
      attendance: scheduleParams.attendance,
      leaveEarly: scheduleParams.leaveEarly,
      lateness: scheduleParams.lateness,
      absence: scheduleParams.absence,
    );
  }

  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    await _groupMemberScheduleDeleteHelper.deleteAllMemberSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }
}
