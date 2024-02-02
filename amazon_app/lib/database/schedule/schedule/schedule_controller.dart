import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'schedule.dart';

class GroupScheduleController {
  ///シングルトンパターンにしています。
  GroupScheduleController._internal();
  static final GroupScheduleController _instance =
      GroupScheduleController._internal();
  static GroupScheduleController get instance => _instance;

  static final db = FirebaseFirestore.instance;

  ///schedule path
  static const collectionPath = 'schedules';

  /// FirestoreのTimestampからDateTimeに変換
  static DateTime? convertTimestampToDateTime(dynamic timestamp) {
    return timestamp is Timestamp ? timestamp.toDate() : null;
  }

  ///Create schudule database.
  ///Return created schedule document ID.
  static Future<void> create(

      ///Named parameters
      {
    required String groupId,
    required String title,
    required String color,
    String? place,
    String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    ///Create new document ID.
    final doc = db.collection(collectionPath).doc();

    ///Get created server time.
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'group_id': groupId,
      'title': title,
      'color': color,
      'place': place,
      'detail': detail,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': createdAt,
    });
  }

  ///Get all schedule database.
  static Future<List<GroupSchedule>> readAll(String groupId) async {
    final QuerySnapshot schedules = await db
        .collection(collectionPath)
        .where(
          'group_id',
          isEqualTo: groupId,
        )
        .get();

    final schedulesRefs = schedules.docs.map((doc) {
      final scheduleRef = doc.data() as Map<String, dynamic>?;
      if (scheduleRef == null) {
        throw Exception('Error: No found document data.');
      }

      return GroupSchedule.fromMap(scheduleRef);
    }).toList();

    return schedulesRefs;
  }

  //Get selected schedule database.
  static Future<GroupSchedule> read(String docId) async {
    final snapshot = await db.collection(collectionPath).doc(docId).get();
    final scheduleRef = snapshot.data();
    if (scheduleRef == null) {
      throw Exception('documentId not found.');
    }

    return GroupSchedule.fromMap(scheduleRef);
  }

  ///Update scheule database.
  ///Group ID can't be changed.
  static Future<void> update({
    required String docId,
    required String groupId,
    required String title,
    required String? place,
    required Color color,
    required String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final updatedAt = FieldValue.serverTimestamp();
    final updateData = <String, dynamic>{
      'group_id': groupId,
      'title': title,
      'place': place,
      'color': color,
      'detail': detail,
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
