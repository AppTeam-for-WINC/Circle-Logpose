import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/interface/i_group_schedule_repository.dart';

import '../../models/group_schedule.dart';

class GroupScheduleRepository  implements IGroupScheduleRepository {
  // Singleton pattern.
  GroupScheduleRepository._internal();
  static final GroupScheduleRepository _instance =
      GroupScheduleRepository._internal();
  static GroupScheduleRepository get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_schedules';

  @override
  Future<String> createAndRetrieveScheduleId({
    required String groupId,
    required String title,
    required String color,
    String? place,
    String? detail,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {
      final doc = db.collection(collectionPath).doc();
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
      throw Exception('Error: failed to create group schedule. ${e.message}');
    }
  }

  @override
  Stream<List<GroupSchedule?>> fetchAllGroupSchedule(String groupId) async* {
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
      throw Exception('Error: Failed to read group ID list. ${e.message}');
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

  @override
  Stream<List<String?>> listenAllScheduleId(String groupId) async* {
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
      throw Exception('Error: failed to watch schedule ID list. ${e.message}');
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

  @override
  Future<List<String?>> fetchAllGroupScheduleId(String groupId) async {
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
      throw Exception('Error: failed to fetch schedule ID list. ${e.message}');
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

  @override
  Future<GroupSchedule> fetchGroupSchedule(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();
      if (data == null) {
        debugPrint('documentId not found.');
        throw Exception('Error: No data.');
      }

      return GroupSchedule.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch schedule. ${e.message}');
    }
  }

  @override
  Future<String> fetchGroupId(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();
      if (data == null) {
        throw Exception('Error: failed to fetch data.');
      }

      return data['group_id'] as String;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group ID. ${e.message}');
    }
  }

  @override
  Future<void> update({
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
      throw Exception('Error: failed to update schedule. ${e.message}');
    }
  }

  @override
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete schedule. ${e.message}');
    }
  }
}
