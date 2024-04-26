import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/database/group/member_schedule.dart';

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
    try {
      await db.collection(collectionPath).doc().set({
        'schedule_id': scheduleId,
        'user_id': userId,
        'attendance': attendance,
        'leave_early': leaveEarly,
        'lateness': lateness,
        'absence': absence,
        'start_at': startAt,
        'end_at': endAt,
        'created_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group member schedule. $e');
    }
  }

  /// Read GroupMemberSchedule.
  static Future<GroupMemberSchedule?> read(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }
      return GroupMemberSchedule.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to read member schedule. $e');
    }
  }

  /// Read GroupMembershipSchedule's doc ID.
  static Future<String?> readDocIdWithScheduleIdAndUserId({
    required String scheduleId,
    required String userDocId,
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

      return _fetchMemberScheduleId(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule ID. $e');
    }
  }

  static String? _fetchMemberScheduleId(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      return doc.id;
    }).first;
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

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return _fetchGroupMemberSchedule(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: Faild to fetch member schedule. $e');
    }
  }

  static GroupMemberSchedule? _fetchGroupMemberSchedule(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      return GroupMemberSchedule.fromMap(data);
    }).first;
  }

  /// Read All GroupMembershipSchedule by GroupScheduleID, UserDocID.
  static Future<List<GroupMemberSchedule?>> readAllGroupMemberSchedule(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      return _fetchGroupMemberScheduleList(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group member schedule list. $e');
    }
  }

  static List<GroupMemberSchedule?> _fetchGroupMemberScheduleList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    try {
      return snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data == null) {
              return null;
            }
            return GroupMemberSchedule.fromMap(data);
          })
          .whereType<GroupMemberSchedule?>()
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to group member schedule list. $e');
    }
  }

  // Read All Memberships's UserDocId under conditions
  // absence != null, absence == false.
  static Future<List<String?>> readAllUserDocIdByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      return _fetchGroupMemberScheduleIdListByTerm(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member docId list by term. $e');
    }
  }

  static List<String?> _fetchGroupMemberScheduleIdListByTerm(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }
      final absence = data['absence'] as bool?;
      final lateness = data['lateness'] as bool?;
      final attendance = data['attendance'] as bool?;
      final leaveEarly = data['leave_early'] as bool?;

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
  }

  // Read All Memberships's Group member schedules under conditions
  // absence != null, absence == false.
  static Future<List<GroupMemberSchedule?>> readAllMemberScheduleByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      return _fetchGroupMemberScheduleListByTerm(snapshot);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule list by term. $e',
      );
    }
  }

  static List<GroupMemberSchedule?> _fetchGroupMemberScheduleListByTerm(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }
      final absence = data['absence'] as bool?;
      final lateness = data['lateness'] as bool?;
      final attendance = data['attendance'] as bool?;
      final leaveEarly = data['leave_early'] as bool?;

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
        return GroupMemberSchedule.fromMap(data);
      }
      return null;
    }).toList();
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
    try {
      final data = <String, dynamic>{
        'updated_at': FieldValue.serverTimestamp(),
      };
      if (attendance != null) {
        data['attendance'] = attendance;
      }

      if (leaveEarly != null) {
        data['leave_early'] = leaveEarly;
      }

      if (lateness != null) {
        data['lateness'] = lateness;
      }

      if (absence != null) {
        data['absence'] = absence;
      }

      if (startAt != null) {
        data['start_at'] = startAt;
      }

      if (endAt != null) {
        data['end_at'] = endAt;
      }

      await db.collection(collectionPath).doc(docId).update(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update group member schedule. $e');
    }
  }

  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group member schedule. $e');
    }
  }
}
