import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_schedule.dart';

class GroupMemberScheduleController {
  GroupMemberScheduleController._internal();
  static final GroupMemberScheduleController _instance =
      GroupMemberScheduleController._internal();
  static GroupMemberScheduleController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'member_condition';

  static Future<void> create({
    required String scheduleId,
    required String userId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime startAt,
    required DateTime endAt,
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

  static Future<GroupMemberSchedule> read(String docId) async {
    final groupMemberScheduleDoc =
        await db.collection(collectionPath).doc(docId).get();
    final groupMemberScheduleRef = groupMemberScheduleDoc.data();
    if (groupMemberScheduleRef == null) {
      throw Exception('Error : No found document data.');
    }

    return GroupMemberSchedule.fromMap(groupMemberScheduleRef);
  }

  static Future<void> update({
    required String docId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{
      'attendance': attendance,
      'leaveEarly': leaveEarly,
      'lateness': lateness,
      'absence': absence,
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
