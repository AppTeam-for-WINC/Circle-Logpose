import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/group_member_schedule.dart';

import '../../interface/i_group_member_schedule_repository.dart';

import '../../mapper/group_member_schedule_mapper.dart';

import '../../model/group_member_schedule_model.dart';

final groupMemberScheduleRepositoryProvider =
    Provider<IGroupMemberScheduleRepository>(
  (ref) => GroupMemberScheduleRepository.instance,
);

class GroupMemberScheduleRepository implements IGroupMemberScheduleRepository {
  GroupMemberScheduleRepository._internal();
  static final GroupMemberScheduleRepository _instance =
      GroupMemberScheduleRepository._internal();
  static GroupMemberScheduleRepository get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_member_schedules';

  @override
  Future<void> createMemberSchedule({
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
      final createdAt = FieldValue.serverTimestamp();

      await db.collection(collectionPath).doc().set({
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
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create member schedule. ${e.message}');
    }
  }

  @override
  Future<GroupMemberSchedule?> fetchMemberSchedule(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        debugPrint('Error : No found document data.');
        return null;
      }

      final model = GroupMemberScheduleModel.fromMap(data);

      return GroupMemberScheduleMapper.toEntity(model);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to read member schedule. $e');
    }
  }

  @override
  Future<List<String>?> fetchMemberScheduleIdListWithUserId(String userId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('user_id', isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return _fetchMemberScheduleIdList(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule. ${e.message}');
    }
  }

  @override
  Future<String?> fetchDocIdWithScheduleIdAndUserId({
    required String scheduleId,
    required String userDocId,
  }) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      return _fetchMemberScheduleId(snapshot);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule ID. ${e.message}',
      );
    }
  }

  static String? _fetchMemberScheduleId(
    QuerySnapshot<Map<String, dynamic>>? snapshot,
  ) {
    try {
      if (snapshot == null) {
        return null;
      }
      return snapshot.docs.map((doc) => doc.id).first;
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule ID. ${e.message}',
      );
    } on Exception catch (e) {
      throw Exception('Member schedule ID does not exist. $e');
    }
  }

  static List<String>? _fetchMemberScheduleIdList(
    QuerySnapshot<Map<String, dynamic>>? snapshot,
  ) {
    try {
      if (snapshot == null) {
        return null;
      }
      return snapshot.docs.map((doc) => doc.id).toList();
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member schedule ID. ${e.message}',
      );
    } on Exception catch (e) {
      throw Exception('Member schedule ID does not exist. $e');
    }
  }

  @override
  Future<GroupMemberSchedule?> fetchMemberScheduleWithUserIdAndScheduleId({
    required String userDocId,
    required String scheduleId,
  }) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return _fetchGroupMemberSchedule(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch member schedule. ${e.message}');
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

      final model = GroupMemberScheduleModel.fromMap(data);

      return GroupMemberScheduleMapper.toEntity(model);
    }).first;
  }

  @override
  Future<List<GroupMemberSchedule?>> fetchAllGroupMemberSchedule(
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
      throw Exception(
        'Error: failed to fetch group member schedule list. ${e.message}',
      );
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
            final model = GroupMemberScheduleModel.fromMap(data);

            return GroupMemberScheduleMapper.toEntity(model);
          })
          .whereType<GroupMemberSchedule?>()
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to group member schedule list. ${e.message}',
      );
    }
  }

  // Fetch Membership ID under conditions
  // absence != null, absence == false.
  @override
  Future<String?> fetchUserIdWithScheduleIdAndUserIdByTerm(
    String scheduleId,
    String userDocId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('schedule_id', isEqualTo: scheduleId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      return _fetchUserIdByTerm(snapshot);
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to fetch member docId list by term. ${e.message}',
      );
    }
  }

  static String? _fetchUserIdByTerm(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    try {
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
          return data['user_id'] as String;
        }
        return null;
      }).first;
    } on Exception catch (e) {
      throw Exception('Error: failed to fetch group member ID. $e');
    }
  }

  // Fetch All Memberships's Group member schedules under conditions
  // absence != null, absence == false.
  @override
  Future<List<GroupMemberSchedule?>> fetchAllMemberScheduleByTerm(
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
        final model = GroupMemberScheduleModel.fromMap(data);

        return GroupMemberScheduleMapper.toEntity(model);
      }
      return null;
    }).toList();
  }

  @override
  Future<void> update({
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
      throw Exception(
        'Error: failed to update group member schedule. ${e.message}',
      );
    }
  }

  @override
  Future<void> deleteMemberSchedule(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group member schedule. $e');
    }
  }
}
