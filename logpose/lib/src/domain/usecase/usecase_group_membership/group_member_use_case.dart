import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_membership_repository.dart';

import '../../entity/user_profile.dart';

import '../../interface/i_group_membership_repository.dart';

import '../usecase_user/user_profile_use_case.dart';
import 'group_member_id_use_case.dart';

final groupMemberUseCaseProvider = Provider<GroupMemberUseCase>((ref) {
  final memberRepository = ref.read(groupMembershipRepositoryProvider);
  final userProfileUseCase = ref.read(userProfileUseCaseProvider);
  final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);

  return GroupMemberUseCase(
    memberRepository: memberRepository,
    userProfileUseCase: userProfileUseCase,
    groupMemberIdUseCase: groupMemberIdUseCase,
  );
});

class GroupMemberUseCase {
  const GroupMemberUseCase({
    required this.memberRepository,
    required this.userProfileUseCase,
    required this.groupMemberIdUseCase,
  });

  final IGroupMembershipRepository memberRepository;
  final UserProfileUseCase userProfileUseCase;
  final GroupMemberIdUseCase groupMemberIdUseCase;

  Future<List<UserProfile?>> fetchUserProfilesNotAbsentList(
    List<String?> membershipIdList,
    String scheduleId,
  ) async {
    try {
      return await Future.wait(
        membershipIdList.where((id) => id != null).map((membershipId) {
          return _retrieveUserProfile(scheduleId, membershipId);
        }).toList(),
      );
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch user profile by terms. $e');
    }
  }

  Future<UserProfile?> _retrieveUserProfile(
    String scheduleId,
    String? membershipId,
  ) async {
    try {
      if (membershipId == null) {
        throw Exception('Error: user ID is null.');
      }

      final userId = await _fetchUserIdWithMembershipId(membershipId);
      return await _fetchUserProfilesNotAbsent(scheduleId, userId);
    } on Exception catch (e) {
      throw Exception('Error: unexcepted error occured. $e');
    }
  }

  Future<String> _fetchUserIdWithMembershipId(String membershipId) async {
    return groupMemberIdUseCase.fetchUserIdWithMembershipId(membershipId);
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
    final responsedUserId = await _fetchUserIdWithScheduleIdAndUserIdByTerm(
      scheduleId,
      userId,
    );

    if (responsedUserId == null) {
      return null;
    }
    return _fetchUserProfile(responsedUserId);
  }

  Future<String?> _fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userId,
  ) async {
    return groupMemberIdUseCase.fetchUserIdWithScheduleIdAndUserIdByTerm(
      scheduleId,
      userId,
    );
  }

  Future<UserProfile?> _fetchUserProfile(String userId) async {
    return userProfileUseCase.fetchUserProfile(userId);
  }
}
