import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/database/group/group_schedule.dart';

class GroupScheduleController {
  // シングルトンパターンにしています。
  GroupScheduleController._internal();
  static final GroupScheduleController _instance =
      GroupScheduleController._internal();
  static GroupScheduleController get instance => _instance;

  static final db = FirebaseFirestore.instance;

  // schedule path
  static const collectionPath = 'group_schedules';

  /// Create schudule database, return doc.id;
  static Future<String> create(

      // Named parameters
      {
    required String groupId,
    required String title,
    required String color,
    String? place,
    String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {
      // Create new document ID.
      final doc = db.collection(collectionPath).doc();

      // Get server time
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

      return doc.id;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group schedule. $e');
    }
  }

  /// Get all schedule database.
  static Stream<List<GroupSchedule?>> readAll(String groupId) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where(
            'group_id',
            isEqualTo: groupId,
          )
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchGroupScheduleList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to read group ID list. $e');
    }
  }

  static List<GroupSchedule?> _fetchGroupScheduleList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      return GroupSchedule.fromMap(data);
    }).toList();
  }

  /// Watch list of schedule ID.
  static Stream<List<String?>> watchAllScheduleId(String groupId) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where(
            'group_id',
            isEqualTo: groupId,
          )
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchGroupScheduleIdList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch schedule ID list. $e');
    }
  }

  static List<String?> _fetchGroupScheduleIdList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      return doc.id;
    }).toList();
  }

  /// Read list of schedule ID.
  static Future<List<String?>> readAllScheduleIdFuture(String groupId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where(
            'group_id',
            isEqualTo: groupId,
          )
          .get();

      return _fetchGroupSchduleData(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch schedule ID list. $e');
    }
  }

  static List<String?> _fetchGroupSchduleData(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      return doc.id;
    }).toList();
  }

  // Get selected schedule database.
  static Future<GroupSchedule?> read(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();
      if (data == null) {
        debugPrint('documentId not found.');
        return null;
      }

      return GroupSchedule.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to read schedule. $e');
    }
  }

  /// Read GroupId.
  static Future<String?> readGroupId(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();
      if (data == null) {
        return null;
      }

      return data['group_id'] as String;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. $e');
    }
  }

  /// Update scheule database.
  /// Group ID can't be changed.
  static Future<void> update({
    required String docId,
    required String groupId,
    required String title,
    required String? place,
    required String color,
    required String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'group_id': groupId,
        'title': title,
        'place': place,
        'color': color,
        'detail': detail,
        'start_at': startAt,
        'end_at': endAt,
        'updated_at': FieldValue.serverTimestamp(),
      };

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update schedule. $e');
    }
  }

  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete schedule. $e');
    }
  }
}
