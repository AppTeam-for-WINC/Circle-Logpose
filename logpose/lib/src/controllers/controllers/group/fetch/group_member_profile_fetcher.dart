import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../models/database/user/user.dart';

import '../../../../server/database/group_schedule_controller.dart';
import '../../../../server/database/member_schedule_controller.dart';
import '../../../../server/database/user_controller.dart';

class GroupMemberProfileFetcher {
  const GroupMemberProfileFetcher();

  Future<String> fetchGroupIdWithScheduleId(String scheduleId) async {
    try {
      return await GroupScheduleController.fetchGroupId(scheduleId);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }

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
    final responsedUserId = await _fetchUserId(
      scheduleId,
      userId,
    );

    if (responsedUserId == null) {
      return null;
    }
    return _fetchUserProfile(responsedUserId);
  }

  Future<String?> _fetchUserId(String scheduleId, String userId) async {
    try {
      return await GroupMemberScheduleController.fetchUserDocIdByTerm(
        scheduleId,
        userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<UserProfile> _fetchUserProfile(String userId) async {
    try {
      return await UserController.fetch(userId);
    } on FirebaseException catch (e) {
      throw Exception('Error: faield to fetch user profile. ${e.message}');
    }
  }
}
