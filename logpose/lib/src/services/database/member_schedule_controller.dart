import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/group/database/member_schedule.dart';
import '../../utils/time/time_utils.dart';

class GroupMemberScheduleController {
  GroupMemberScheduleController._internal();
  static final GroupMemberScheduleController _instance =
      GroupMemberScheduleController._internal();
  static GroupMemberScheduleController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_member_schedules';

  /// Create GroupMembershipSchedule.
  static Future<void> create({
    required String scheduleId,
    required String userId,
    bool attendance = false,
    bool leaveEarly = false,
    bool lateness = false,
    bool absence = false,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    final groupMemberScheduleDoc = db.collection(collectionPath).doc();

    final createdAt = FieldValue.serverTimestamp();

    await groupMemberScheduleDoc.set({
      'schedule_id': scheduleId,
      'user_id': userId,
      'attendance': attendance,
      'leave_early': leaveEarly,
      'lateness': lateness,
      'absence': absence,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': createdAt,
    });
  }

  /// Read GroupMemberSchedule.
  static Future<GroupMemberSchedule?> read(String docId) async {
    final groupMemberScheduleDoc =
        await db.collection(collectionPath).doc(docId).get();
    final groupMemberScheduleRef = groupMemberScheduleDoc.data();
    if (groupMemberScheduleRef == null) {
      throw Exception('Error : No found document data.');
    }
    final scheduleId = groupMemberScheduleRef['schedule_id'] as String;
    final userId = groupMemberScheduleRef['user_id'] as String;
    final attendance = groupMemberScheduleRef['attendance'] as bool;
    final leaveEarly = groupMemberScheduleRef['leave_early'] as bool;
    final lateness = groupMemberScheduleRef['lateness'] as bool;
    final absence = groupMemberScheduleRef['absence'] as bool;
    final startAt = convertTimestampToDateTime(
      groupMemberScheduleRef['start_at'],
    );
    final endAt = convertTimestampToDateTime(groupMemberScheduleRef['end_at']);
    final updatedAt = groupMemberScheduleRef['updated_at'] as Timestamp?;
    final createdAt = groupMemberScheduleRef['created_at'] as Timestamp?;
    if (createdAt == null) {
      return null;
    }

    return GroupMemberSchedule(
      scheduleId: scheduleId,
      userId: userId,
      attendance: attendance,
      leaveEarly: leaveEarly,
      lateness: lateness,
      absence: absence,
      startAt: startAt,
      endAt: endAt,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  /// Read GroupMembershipSchedule's doc ID.
  static Future<String?> readDocIdWithScheduleIdAndUserId({
    required String scheduleId,
    required String userDocId,
  }) async {
    final groupMemberScheduleSnapshot = await db
        .collection(collectionPath)
        .where(
          'schedule_id',
          isEqualTo: scheduleId,
        )
        .where(
          'user_id',
          isEqualTo: userDocId,
        )
        .get();

    final groupMemberScheduleId = groupMemberScheduleSnapshot.docs.map((doc) {
      final groupMembershipScheduleRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipScheduleRef == null) {
        return null;
      }

      return doc.id;
    }).first;

    return groupMemberScheduleId;
  }

  /// Read GroupMembershipSchedule.
  static Future<GroupMemberSchedule?> readGroupMemberSchedule({
    required String userDocId,
    required String scheduleId,
  }) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where(
            'schedule_id',
            isEqualTo: scheduleId,
          )
          .where(
            'user_id',
            isEqualTo: userDocId,
          )
          .get();

      return snapshot.docs.map((doc) {
        final groupMembershipScheduleRef = doc.data() as Map<String, dynamic>?;
        if (groupMembershipScheduleRef == null) {
          return null;
        }

        final attendance = groupMembershipScheduleRef['attendance'] as bool;
        final leaveEarly = groupMembershipScheduleRef['leave_early'] as bool;
        final lateness = groupMembershipScheduleRef['lateness'] as bool;
        final absence = groupMembershipScheduleRef['absence'] as bool;
        final startAt =
            convertTimestampToDateTime(groupMembershipScheduleRef['start_at']);
        final endAt =
            convertTimestampToDateTime(groupMembershipScheduleRef['end_at']);
        final updatedAt =
            groupMembershipScheduleRef['updated_at'] as Timestamp?;
        final createdAt =
            groupMembershipScheduleRef['created_at'] as Timestamp?;
        if (createdAt == null) {
          return null;
        }

        return GroupMemberSchedule(
          scheduleId: scheduleId,
          userId: userDocId,
          attendance: attendance,
          leaveEarly: leaveEarly,
          lateness: lateness,
          absence: absence,
          startAt: startAt,
          endAt: endAt,
          updatedAt: updatedAt,
          createdAt: createdAt,
        );
      }).first;
    } on FirebaseException catch (e) {
      throw Exception('Error: Faild to read data. $e');
    }
  }

  /// Read All GroupMembershipSchedule by GroupScheduleID, UserDocID.
  static Future<List<GroupMemberSchedule?>> readAllGroupMemberSchedule(
    String scheduleId,
    String userDocId,
  ) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('schedule_id', isEqualTo: scheduleId)
        .where('user_id', isEqualTo: userDocId)
        .get();

    final groupMemberScheduleList = snapshot.docs
        .map((doc) {
          final groupMembershipScheduleRef =
              doc.data() as Map<String, dynamic>?;
          if (groupMembershipScheduleRef == null) {
            return null;
          }

          final attendance = groupMembershipScheduleRef['attendance'] as bool;
          final leaveEarly = groupMembershipScheduleRef['leave_early'] as bool;
          final lateness = groupMembershipScheduleRef['lateness'] as bool;
          final absence = groupMembershipScheduleRef['absence'] as bool;
          final startAt = convertTimestampToDateTime(
            groupMembershipScheduleRef['start_at'],
          );
          final endAt =
              convertTimestampToDateTime(groupMembershipScheduleRef['end_at']);
          final updatedAt =
              groupMembershipScheduleRef['updated_at'] as Timestamp?;
          final createdAt =
              groupMembershipScheduleRef['created_at'] as Timestamp?;
          if (createdAt == null) {
            return null;
          }

          return GroupMemberSchedule(
            scheduleId: scheduleId,
            userId: userDocId,
            attendance: attendance,
            leaveEarly: leaveEarly,
            lateness: lateness,
            absence: absence,
            startAt: startAt,
            endAt: endAt,
            updatedAt: updatedAt,
            createdAt: createdAt,
          );
        })
        .whereType<GroupMemberSchedule?>()
        .toList();

    return groupMemberScheduleList;
  }

  // Read All MemberSchedule's doc ID under conditions
  // absence != null, absence == false.
  static Future<List<String?>> readAllMemberScheduleIdByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('schedule_id', isEqualTo: scheduleId)
        .where('user_id', isEqualTo: userDocId)
        .get();

    final docIdList = snapshot.docs.map((doc) {
      final memberScheduleData = doc.data() as Map<String, dynamic>?;
      if (memberScheduleData == null) {
        return null;
      }
      final absence = memberScheduleData['absence'] as bool?;
      final lateness = memberScheduleData['lateness'] as bool?;
      final attendance = memberScheduleData['attendance'] as bool?;
      final leaveEarly = memberScheduleData['leave_early'] as bool?;

      if (absence == null ||
          lateness == null ||
          attendance == null ||
          leaveEarly == null) {
        return null;
      }
      if (!absence && !lateness && !attendance && !leaveEarly) {
        return null;
      }

      if (!absence) {
        return doc.id;
      }
      return null;
    }).toList();

    return docIdList;
  }

  // Read All Memberships's UserDocId under conditions
  // absence != null, absence == false.
  static Future<List<String?>> readAllUserDocIdByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('schedule_id', isEqualTo: scheduleId)
        .where('user_id', isEqualTo: userDocId)
        .get();

    final userIdList = snapshot.docs.map((doc) {
      final memberScheduleData = doc.data() as Map<String, dynamic>?;
      if (memberScheduleData == null) {
        return null;
      }
      final absence = memberScheduleData['absence'] as bool?;
      final lateness = memberScheduleData['lateness'] as bool?;
      final attendance = memberScheduleData['attendance'] as bool?;
      final leaveEarly = memberScheduleData['leave_early'] as bool?;

      if (absence == null ||
          lateness == null ||
          attendance == null ||
          leaveEarly == null) {
        return null;
      }
      if (!absence && !lateness && !attendance && !leaveEarly) {
        return null;
      }

      if (!absence) {
        return userDocId;
      }
      return null;
    }).toList();

    return userIdList;
  }

  // Read All Memberships's Group member schedules under conditions
  // absence != null, absence == false.
  static Future<List<GroupMemberSchedule?>> readAllMemberScheduleByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('schedule_id', isEqualTo: scheduleId)
        .where('user_id', isEqualTo: userDocId)
        .get();

    final groupMemberScheduleList = snapshot.docs.map((doc) {
      final memberScheduleData = doc.data() as Map<String, dynamic>?;
      if (memberScheduleData == null) {
        return null;
      }
      final absence = memberScheduleData['absence'] as bool?;
      final lateness = memberScheduleData['lateness'] as bool?;
      final attendance = memberScheduleData['attendance'] as bool?;
      final leaveEarly = memberScheduleData['leave_early'] as bool?;

      if (absence == null ||
          lateness == null ||
          attendance == null ||
          leaveEarly == null) {
        return null;
      }
      if (!absence && !lateness && !attendance && !leaveEarly) {
        return null;
      }

      if (!absence) {
        final userId = memberScheduleData['user_id'] as String;
        final startAt =
            convertTimestampToDateTime(memberScheduleData['start_at']);
        final endAt = convertTimestampToDateTime(memberScheduleData['end_at']);
        final updatedAt = memberScheduleData['updated_at'] as Timestamp?;
        final createdAt = memberScheduleData['created_at'] as Timestamp?;
        if (createdAt == null) {
          return null;
        }

        return GroupMemberSchedule(
          scheduleId: scheduleId,
          userId: userId,
          attendance: attendance,
          leaveEarly: leaveEarly,
          lateness: lateness,
          absence: absence,
          startAt: startAt,
          endAt: endAt,
          updatedAt: updatedAt,
          createdAt: createdAt,
        );
      }
      return null;
    }).toList();

    return groupMemberScheduleList;
  }

  /// Update GroupMembershipSchedule.
  static Future<void> update({
    required String docId,
    bool? attendance,
    bool? leaveEarly,
    bool? lateness,
    bool? absence,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{'updated_at': updatedAt};
    if (attendance != null) {
      updateData['attendance'] = attendance;
    }

    if (leaveEarly != null) {
      updateData['leave_early'] = leaveEarly;
    }

    if (lateness != null) {
      updateData['lateness'] = lateness;
    }

    if (absence != null) {
      updateData['absence'] = absence;
    }

    if (startAt != null) {
      updateData['start_at'] = startAt;
    }

    if (endAt != null) {
      updateData['end_at'] = endAt;
    }

    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
