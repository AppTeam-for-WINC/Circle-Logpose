import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_condition.dart';

class MemberConditionController {
  const MemberConditionController();

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'member_condition';

  static Future<void> create(
    {
      required String scheduleId,
      required String userId,
      required String attendance,
      required String leaveEarly,
      required String lateness,
      required String absence,
      required DateTime startAt,
      required DateTime endAt,
    }
  ) async {
    final doc = db.collection(collectionPath).doc();

    final startTimestamp = Timestamp.fromDate(startAt);
    final endTimestamp = Timestamp.fromDate(endAt);

    await doc.set({
      'schedule_id': scheduleId,
      'user_id': userId,
      'attendance': attendance,
      'leave_early': leaveEarly,
      'lateness': lateness,
      'absence': absence,
      'start_at': startTimestamp,
      'end_at': endTimestamp,
    });
  }

  static Future<MemberCondition> read(String userId, String scheduleId) async{
    final QuerySnapshot snapshot = await db.collection(collectionPath)
      .where('user_id', isEqualTo: userId)
      .where('schedule_id', isEqualTo: scheduleId)
      .get();
        
    if (snapshot.docs.isEmpty) {
      throw Exception('documentId not found');
    }

    ///Get the first document that satisfies the terms.
    final doc = snapshot.docs.first;
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('documentId not found.');
    }

    final attendance = data['attendance'] as bool;
    final leaveEarly = data['leave_early'] as bool;
    final lateness = data['lateness'] as bool;
    final absence = data['absence'] as bool;
    final startAt = data['start_at'] as Timestamp;
    final endAt =data['end_at'] as Timestamp;

    return MemberCondition(
      scheduleId: scheduleId,
      userId: userId,
      documentId: doc.id,
      attendance: attendance,
      leaveEarly: leaveEarly,
      lateness: lateness,
      absence: absence,
      startAt: startAt,
      endAt: endAt,
    );
  }

  static Future<void> update({
    required String documentId,
    required bool attendance,
    required bool leaveEarly,
    required bool lateness,
    required bool absence,
    required DateTime startAt,
    required DateTime endAt,
  }) async{
    final updateData = <String, dynamic>{
      'attendance': attendance,
      'leaveEarly': leaveEarly,
      'lateness': lateness,
      'absence': absence,
      'start_at': Timestamp.fromDate(startAt),
      'end_at': Timestamp.fromDate(endAt),
    };

    await db.collection(collectionPath).doc(documentId).update(updateData);
  }

  static Future<void> delete(String documentId) async{
    await db.collection(collectionPath).doc(documentId).delete();
  }
}
