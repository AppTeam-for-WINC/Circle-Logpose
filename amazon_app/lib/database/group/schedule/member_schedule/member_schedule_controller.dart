import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'member_schedule.dart';

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
    final startAt = groupMemberScheduleRef['start_at'] as DateTime?;
    final endAt = groupMemberScheduleRef['end_at'] as DateTime?;
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

    final groupMemberSchedule = groupMemberScheduleSnapshot.docs.map((doc) {
      final groupMembershipScheduleRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipScheduleRef == null) {
        return null;
      }

      return doc.id;
    }).first;
    return groupMemberSchedule;
  }

  /// Read GroupMembershipSchedule by GroupScheduleID, UserDocID.
  static Future<GroupMemberSchedule?> readWithScheduleIdAndUserId(
    String scheduleId,
    String userDocId,
  ) async {
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

    final groupMemberSchedule = groupMemberScheduleSnapshot.docs.map((doc) {
      final groupMembershipScheduleRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipScheduleRef == null) {
        return null;
      }
      final scheduleId = groupMembershipScheduleRef['schedule_id'] as String;
      final userId = groupMembershipScheduleRef['user_id'] as String;
      final attendance = groupMembershipScheduleRef['attendance'] as bool;
      final leaveEarly = groupMembershipScheduleRef['leave_early'] as bool;
      final lateness = groupMembershipScheduleRef['lateness'] as bool;
      final absence = groupMembershipScheduleRef['absence'] as bool;
      final startAt = groupMembershipScheduleRef['start_at'] as DateTime?;
      final endAt = groupMembershipScheduleRef['end_at'] as DateTime?;
      final updatedAt = groupMembershipScheduleRef['updated_at'] as Timestamp?;
      final createdAt = groupMembershipScheduleRef['created_at'] as Timestamp?;
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
    }).first;

    return groupMemberSchedule;
  }

  // Read AlMemberships's UserDocId under conditions
  // absence != null, absence == false.
  static Stream<List<String?>> readAllMembershipUserDocIdByTerm(
    String scheduleId,
    String userDocId,
  ) async* {
    final groupMemberScheduleStream = db
        .collection(collectionPath)
        .where(
          'schedule_id',
          isEqualTo: scheduleId,
        )
        .where(
          'user_id',
          isEqualTo: userDocId,
        )
        .snapshots();

    await for (final groupMemberSchedules in groupMemberScheduleStream) {
      final groupMemberSchedulesUserDocIds = groupMemberSchedules.docs
          .map((doc) {
            final groupMemberSchedulesRef = doc.data() as Map<String, dynamic>?;
            if (groupMemberSchedulesRef == null) {
              debugPrint('Error : No found document data.');
              return null;
            }
            final absence = groupMemberSchedulesRef['absence'] as bool?;
            if (absence == null || !absence) {
              final userDocId = groupMemberSchedulesRef['user_id'] as String;
              return userDocId;
            }
            return null;
          })
          .whereType<String>()
          .toList();

      yield groupMemberSchedulesUserDocIds;
    }
  }

  /// Update GroupMembershipSchedule.
  static Future<void> update({
    required String docId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime? startAt,
    required DateTime? endAt,
  }) async {
    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{
      'attendance': attendance,
      'leave_early': leaveEarly,
      'lateness': lateness,
      'absence': absence,
      'start_at': startAt,
      'end_at': endAt,
      'updated_at': updatedAt,
    };

    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  /// Update GroupMembershipSchedule.
  static Future<void> updateTime({
    required String docId,
    required DateTime? startAt,
    required DateTime? endAt,
  }) async {
    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{
      'start_at': startAt,
      'end_at': endAt,
      'updated_at': updatedAt,
    };

    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
