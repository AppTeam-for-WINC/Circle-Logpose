import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../interface/i_group_member_schedule_repository.dart';

import '../../providers/repository/group_member_schedule_repository_provider.dart';

import '../usecase_user/user_profile_use_case.dart';
import 'group_member_id_use_case.dart';

final groupMemberUseCaseProvider = Provider<GroupMemberUseCase>((ref) {
  final memberScheduleRepository =
      ref.read(groupMemberScheduleRepositoryProvider);
  final userProfileUseCase = ref.read(userProfileUseCaseProvider);
  final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);

  return GroupMemberUseCase(
    memberScheduleRepository: memberScheduleRepository,
    userProfileUseCase: userProfileUseCase,
    groupMemberIdUseCase: groupMemberIdUseCase,
  );
});

class GroupMemberUseCase {
  const GroupMemberUseCase({
    required this.memberScheduleRepository,
    required this.userProfileUseCase,
    required this.groupMemberIdUseCase,
  });

  final IGroupMemberScheduleRepository memberScheduleRepository;
  final UserProfileUseCase userProfileUseCase;
  final GroupMemberIdUseCase groupMemberIdUseCase;

  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> userIdList,
    String scheduleId,
  ) async {
    try {
      return await Future.wait(
        userIdList.where((id) => id != null).map((userId) {
          return _retrieveUserProfile(scheduleId, userId);
        }).toList(),
      );
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch user profile by terms. $e');
    }
  }

  Future<UserProfile?> _retrieveUserProfile(
    String scheduleId,
    String? userId,
  ) async {
    try {
      if (userId == null) {
        throw Exception('Error: user ID is null.');
      }
      return await _fetchUserProfilesNotAbsent(scheduleId, userId);
    } on Exception catch (e) {
      throw Exception('Error: unexcepted error occured. $e');
    }
  }

  Future<UserProfile?> _fetchUserProfilesNotAbsent(
    String scheduleId,
    String userId,
  ) async {
    try {
      return await _attemptToFetchUserProfile(scheduleId, userId);
    } on Exception catch (e) {
      debugPrint('Error fetching profiles: $e');
      return null;
    }
  }

  Future<UserProfile?> _attemptToFetchUserProfile(
    String scheduleId,
    String userId,
  ) async {
    final responsedUserId = await _fetchMembershipIdWithScheduleIdAndUserId(
      scheduleId,
      userId,
    );

    if (responsedUserId == null) {
      return null;
    }
    return _fetchUserProfile(responsedUserId);
  }

  Future<String?> _fetchMembershipIdWithScheduleIdAndUserId(
    String scheduleId,
    String userId,
  ) async {
    return groupMemberIdUseCase.fetchMembershipIdWithScheduleIdAndUserId(
      scheduleId,
      userId,
    );
  }

  Future<UserProfile> _fetchUserProfile(String userId) async {
    return userProfileUseCase.fetchUserProfile(userId);
  }
}
