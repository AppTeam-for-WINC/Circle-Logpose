import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_schedule.dart';

class GroupMemberScheduleController {
  const GroupMemberScheduleController();

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'member_condition';

  static Future<void> create(
    {
      required String scheduleId,
      required String userId,
      required bool attendance,
      required bool leaveEarly,
      required bool lateness,
      required bool absence,
      required DateTime startAt,
      required DateTime endAt,
    }
  ) async {
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

  static Future<GroupMemberSchedule> read(String docId) async{
    final groupMemberScheduleDoc = await db.collection(collectionPath).doc(docId).get();
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
    final startAt = groupMemberScheduleRef['start_at'] as DateTime;
    final endAt = groupMemberScheduleRef['end_at'] as DateTime;
    final updatedAt = groupMemberScheduleRef['updated_at'] as Timestamp?;
    final createdAt = groupMemberScheduleRef['created_at'] as Timestamp;

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

  static Future<void> update({
    required String docId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime startAt,
    required DateTime endAt,
  }) async{
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

  static Future<void> delete(String docId) async{
    await db.collection(collectionPath).doc(docId).delete();
  }
}
