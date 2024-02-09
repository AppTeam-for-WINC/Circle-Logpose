import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/group/group.dart';
import 'package:amazon_app/database/group/group/group_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:amazon_app/database/group/schedule/member_schedule/member_schedule_controller.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule.dart';
import 'package:amazon_app/database/group/schedule/schedule/schedule_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class UpdateGroupMemberSchedule {
  UpdateGroupMemberSchedule._internal();
  static final UpdateGroupMemberSchedule _instance =
      UpdateGroupMemberSchedule._internal();
  static UpdateGroupMemberSchedule get instance => _instance;

  static Future<void> update({
    required String docId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime? startAt,
    required DateTime? endAt,
  }) async {
    try {
      await GroupMemberScheduleController.update(
      docId: docId,
      attendance: attendance,
      leaveEarly: leaveEarly,
      lateness: lateness,
      absence: absence,
      startAt: startAt,
      endAt: endAt,
    );
    } on FirebaseException catch (e) {
      throw Exception('Failed to update database. $e');
    }
  }
}

class GroupProfileWithScheduleWithId {
  GroupProfileWithScheduleWithId({
    required this.groupScheduleId,
    required this.groupSchedule,
    required this.groupId,
    required this.groupProfile,
  });
  final String groupScheduleId;
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
      await GroupMembershipController.readAllWithUserId(userDocId).first;

  List<GroupProfileWithScheduleWithId> combinedSchedules = [];

  for (final membership in groupMemberships) {
    if (membership == null) {
      continue;
    }

    final groupProfile = await GroupController.read(membership.groupId).first;
    final scheduleIds =
        await GroupScheduleController.readAllScheduleId(membership.groupId)
            .first;

    if (groupProfile == null) {
      continue;
    }

    for (final scheduleId in scheduleIds) {
      if (scheduleId == null) {
        continue;
      }

      final schedule = await GroupScheduleController.read(scheduleId);

      if (schedule != null) {
        combinedSchedules.add(
          GroupProfileWithScheduleWithId(
            groupScheduleId: scheduleId,
            groupSchedule: schedule,
            groupId: membership.groupId,
            groupProfile: groupProfile,
          ),
        );
      }
    }
  }

  yield combinedSchedules;
});


//   final groupMemberships =
//       GroupMembershipController.readAllWithUserId(userDocId);

//   await for (final memberships in groupMemberships) {
//     final futures =
//         memberships.whereType<GroupMembership>().map((membership) async {
//       final schedulesStream =
//           GroupScheduleController.readAll(membership.groupId);
//       final groupStream = GroupController.read(membership.groupId);
//       final scheduleIdStream =
//           GroupScheduleController.readAllScheduleId(membership.groupId);
//       await for (final scheduleIdList in scheduleIdStream) {
//         await Future.wait(
//           scheduleIdList.map((scheduleId) async {
//             if (scheduleId == null) {
//               return null;
//             }
//             await for (final group in groupStream) {
//               if (group == null) {
//                 continue;
//               }
//               await for (final schedules in schedulesStream) {
//                 final scheduleList = await Future.wait(
//                   schedules.map((schedule) async {
//                     if (schedule == null) {
//                       return null;
//                     }
//                     final scheduleWithId = GroupProfileWithScheduleWithId(
//                       groupScheduleId: scheduleId,
//                       groupSchedule: schedule,
//                       groupId: membership.groupId,
//                       groupProfile: group,
//                     );
//                     return scheduleWithId;
//                   }),
//                 );
//                 return scheduleList
//                     .whereType<GroupProfileWithScheduleWithId>()
//                     .toList();
//               }
//             }
//           }),
//         );
//       }
//     });

//     final scheduleLists = await Future.wait(futures);
//     yield scheduleLists
//         .whereType<List<GroupProfileWithScheduleWithId>>()
//         .expand((x) => x)
//         .toList();
//   }
// });
