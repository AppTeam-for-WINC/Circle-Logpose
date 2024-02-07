import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkGroupExistProvider = StreamProvider<bool>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final groupIsExistStream =
      GroupMembershipController.readAllWithUserId(userDocId);

  await for (final groupIsExist in groupIsExistStream) {
    yield groupIsExist.isNotEmpty;
  }
});

class GroupProfileWithScheduleWithId {
  GroupProfileWithScheduleWithId({
    required this.groupSchedule,
    required this.groupId,
    required this.groupProfile,
  });
  final GroupSchedule groupSchedule;
  final String groupId;
  final GroupProfile groupProfile;
}

final readUserScheduleProvider =
    StreamProvider<List<GroupProfileWithScheduleWithId>>((ref) async* {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }

  final groupMemberships =
      GroupMembershipController.readAllWithUserId(userDocId);

  await for (final memberships in groupMemberships) {
    final futures =
        memberships.whereType<GroupMembership>().map((membership) async {
      final schedulesStream =
          GroupScheduleController.readAll(membership.groupId);
      final groupStream = GroupController.read(membership.groupId);
      await for (final group in groupStream) {
        if (group == null) {
          continue;
        }
        await for (final schedules in schedulesStream) {
          final scheduleList = await Future.wait(
            schedules.map((schedule) async {
              if (schedule == null) {
                return null;
              }
              final scheduleWithId = GroupProfileWithScheduleWithId(
                groupSchedule: schedule,
                groupId: membership.groupId,
                groupProfile: group,
              );
              return scheduleWithId;
            }),
          );
          return scheduleList
              .whereType<GroupProfileWithScheduleWithId>()
              .toList();
        }
      }
    });

    final scheduleLists = await Future.wait(futures);
    yield scheduleLists
        .whereType<List<GroupProfileWithScheduleWithId>>()
        .expand((x) => x)
        .toList();
  }
});
