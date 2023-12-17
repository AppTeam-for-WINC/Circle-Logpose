import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'user_schedule_history.dart';

class UserScheduleHistoryController {
  const UserScheduleHistoryController();

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'user_schedule_histories';

  static Future<void> create(

      ///Named parameters
      {
    required String scheduleId,
    required String userId,
    required String groupId,
    required String title,
    required Color color,
    String? place,
    String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    ///Create new document ID.
    final doc = db.collection(collectionPath).doc();

    ///Change Color from String of type.
    final colorToString = color.toString();

    ///Get created server time.
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'schedule_id': scheduleId,
      'user_id': userId,
      'group_id': groupId,
      'title': title,
      'color': colorToString,
      'place': place,
      'detail': detail,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': createdAt,
    });
  }

  static Future<List<UserScheduleHistory>> readAll(String groupId) async {
    final QuerySnapshot snapshot = await db.collection(collectionPath).get();

    final schedules = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error: No found document data.');
      }

      final documentId = doc.id;
      final scheduleId = data['schedule_id'] as String;
      final userId = data['user_id'] as String;
      final groupId = data['group_id'] as String;
      final title = data['title'] as String;
      final color = data['color'] as Color;
      final place = data['place'] as String?;
      final detail = data['detail'] as String?;
      final startAt = data['start_at'] as DateTime;
      final endAt = data['end_at'] as DateTime;
      final createdAt = data['created_at'] as DateTime?;

      return UserScheduleHistory(
        documentId: documentId,
        scheduleId: scheduleId,
        userId: userId,
        groupId: groupId,
        title: title,
        color: color,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
        createdAt: createdAt,
      );
    }).toList();

    return schedules;
  }

  static Stream<List<UserScheduleHistory>> watch() async* {
    final schedulesStream =
        db.collection('user_schedule_histories').snapshots();

    await for (final scheduleSnapshot in schedulesStream) {
      final schedules = <UserScheduleHistory>[];

      for (final doc in scheduleSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw Exception('Error: No found document data.');
        }

        final scheduleId = data['schedule_id'] as String;
        final userId = data['user_id'] as String;
        final groupId = data['group_id'] as String;
        final title = data['title'] as String;
        final color = data['color'] as Color;
        final place = data['place'] as String?;
        final detail = data['detail'] as String?;
        final startAt = (data['start_at'] as Timestamp).toDate();
        final endAt = (data['end_at'] as Timestamp).toDate();
        final createdAt = (data['created_at'] as Timestamp?)?.toDate();

        schedules.add(
          UserScheduleHistory(
            documentId: doc.id,
            scheduleId: scheduleId,
            userId: userId,
            groupId: groupId,
            title: title,
            color: color,
            place: place,
            detail: detail,
            startAt: startAt,
            endAt: endAt,
            createdAt: createdAt,
          ),
        );
      }

      yield schedules;
    }
  }
}
