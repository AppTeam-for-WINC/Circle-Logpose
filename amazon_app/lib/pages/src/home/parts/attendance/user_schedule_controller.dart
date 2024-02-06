import 'package:amazon_app/database/auth/auth_controller.dart';
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

class GroupScheduleWithId {
  GroupScheduleWithId({
    required this.groupSchedule,
    required this.groupId,
    required this.groupImage,
  });
  final GroupSchedule groupSchedule;
  final String groupId;
  final String groupImage;
}

final readUserScheduleProvider =
    StreamProvider<List<GroupScheduleWithId>>((ref) async* {
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
      final groupProfile = await GroupController.read(membership.groupId);
      await for (final schedules in schedulesStream) {
        final scheduleList = await Future.wait(
          schedules.map((schedule) async {
            if (schedule == null) {
              return null;
            }
            final scheduleWithId = GroupScheduleWithId(
              groupSchedule: schedule,
              groupId: membership.groupId,
              groupImage: groupProfile.image,
            );
            return scheduleWithId;
          }),
        );
        return scheduleList.whereType<GroupScheduleWithId>().toList();
      }
    });

    final scheduleLists = await Future.wait(futures);
    yield scheduleLists
        .whereType<List<GroupScheduleWithId>>()
        .expand((x) => x)
        .toList();
  }
});
