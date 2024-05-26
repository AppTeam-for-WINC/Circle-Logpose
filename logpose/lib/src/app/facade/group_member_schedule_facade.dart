import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/group_member_schedule.dart';
import '../../domain/entity/user_profile.dart';

import '../../domain/interface/group_member_schedule/i_group_member_schedule_creation_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_delete_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_id_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_init_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_listen_reponsed_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_update_use_case.dart';
import '../../domain/interface/group_member_schedule/i_group_member_schedule_use_case.dart';

import '../../domain/model/schedule_response_params_model.dart';

import '../../domain/usecase/usecase_member_schedule/group_member_schedule_creation_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_delete_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_id_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_init_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_listen_responsed_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_update_use_case.dart';
import '../../domain/usecase/usecase_member_schedule/group_member_schedule_use_case.dart';

final groupMemberScheduleFacadeProvider = Provider<GroupMemberScheduleFacade>(
  (ref) => GroupMemberScheduleFacade(ref: ref),
);

class GroupMemberScheduleFacade {
  GroupMemberScheduleFacade({required this.ref})
      : _groupMemberScheduleCreationUseCase =
            ref.read(groupMemberScheduleCreationUseCaseProvider),
        _groupMemberScheduleIdUseCase =
            ref.read(groupMemberScheduleIdUseCaseProvider),
        _groupMemberScheduleUseCase =
            ref.read(groupMemberScheduleUseCaseProvider),
        _groupMemberScheduleUpdateUseCase =
            ref.read(groupMemberScheduleUpdateUseCaseProvider),
        _groupMemberScheduleDeleteUseCase =
            ref.read(groupMemberScheduleDeleteUseCaseProvider),
        _groupMemberScheduleInitUseCase =
            ref.read(groupMemberScheduleInitUseCaseProvider),
        _groupMemberScheduleListenResponsedUseCase =
            ref.read(groupMemberScheduleListenResponsedUseCaseProvider);

  final Ref ref;
  final IGroupMemberScheduleCreationUseCase _groupMemberScheduleCreationUseCase;
  final IGroupMemberScheduleIdUseCase _groupMemberScheduleIdUseCase;
  final IGroupMemberScheduleUseCase _groupMemberScheduleUseCase;
  final IGroupMemberScheduleUpdateUseCase _groupMemberScheduleUpdateUseCase;
  final IGroupMemberScheduleDeleteUseCase _groupMemberScheduleDeleteUseCase;
  final IGroupMemberScheduleInitUseCase _groupMemberScheduleInitUseCase;
  final IGroupMemberScheduleListenResponsedUseCase
      _groupMemberScheduleListenResponsedUseCase;

  Future<void> createMemberSchedule(String scheduleId, String userId) async {
    await _groupMemberScheduleCreationUseCase.createMemberSchedule(
      scheduleId,
      userId,
    );
  }

  Future<void> createAllMemberSchedule(
    String groupId,
    String scheduleId,
  ) async {
    await _groupMemberScheduleCreationUseCase.createAllMemberSchedule(
      groupId,
      scheduleId,
    );
  }

  Future<String?> fetchMemberScheduleId(
    String groupScheduleId,
    String userDocId,
  ) async {
    return _groupMemberScheduleIdUseCase.fetchMemberScheduleId(
      groupScheduleId,
      userDocId,
    );
  }

  Future<GroupMemberSchedule> fetchMemberSchedule(
    String memberScheduleId,
  ) async {
    return _groupMemberScheduleUseCase.fetchMemberSchedule(memberScheduleId);
  }

  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId(
    String userDocId,
    String scheduleId,
  ) async {
    return _groupMemberScheduleUseCase
        .fetchMemberScheduleWithUserIdAndScheduleId(
      userDocId,
      scheduleId,
    );
  }

  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    return _groupMemberScheduleUpdateUseCase.updateStartAt(
      memberScheduleId,
      startAt,
    );
  }

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    return _groupMemberScheduleUpdateUseCase.updateEndAt(
      memberScheduleId,
      endAt,
    );
  }

  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    return _groupMemberScheduleUpdateUseCase.updateResponse(scheduleParams);
  }

  Future<void> deleteAllMemberSchedule(
    List<UserProfile?> groupMemberList,
    String groupScheduleId,
  ) async {
    await _groupMemberScheduleDeleteUseCase.deleteAllMemberSchedule(
      groupMemberList,
      groupScheduleId,
    );
  }

  Future<GroupMemberSchedule?> initMemberSchedule(
    String groupScheduleId,
  ) async {
    return _groupMemberScheduleInitUseCase.initMemberSchedule(groupScheduleId);
  }

  Stream<GroupMemberSchedule?> listenResponsedGroupMemberSchedule(
    String scheduleId,
    String accountId,
  ) {
    return _groupMemberScheduleListenResponsedUseCase
        .listenResponsedGroupMemberSchedule(scheduleId, accountId);
  }
}
