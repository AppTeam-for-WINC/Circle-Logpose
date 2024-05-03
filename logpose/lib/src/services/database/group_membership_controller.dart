import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/database/group/group_membership.dart';
import '../../models/database/user/user.dart';
import 'user_controller.dart';

class GroupMembershipController {
  GroupMembershipController._internal();
  static final GroupMembershipController _instance =
      GroupMembershipController._internal();
  static GroupMembershipController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'group_memberships';

  /// Added the group to new member.
  static Future<void> create(
    String userDocId,
    String role,
    String groupId,
  ) async {
    try {
      final groupMembershipDoc = db.collection(collectionPath).doc();
      final data = (await db.collection('users').doc(userDocId).get()).data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      await groupMembershipDoc.set({
        'user_id': userDocId,
        'username': data['name'] as String,
        'user_description': data['description'] as String?,
        'group_id': groupId,
        'role': role,
        'created_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create group membership database. $e');
    }
  }

  /// Read all memgber's doc ID.
  static Future<List<String>> readAllUserDocIdWithGroupId(
    String groupId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .get();

      return _fetchuserDocIdList(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group member docId. $e');
    }
  }

  /// Watch all memgber's doc ID.
  static Stream<List<String?>> watchAllUserDocIdWithGroupId(
    String groupId,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchuserDocIdList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user docId list. $e');
    }
  }

  static List<String> _fetchuserDocIdList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final userDocId = doc.data()['user_id'] as String?;
      if (userDocId == null) {
        throw Exception('No found document data.');
      }
      return userDocId;
    }).toList();
  }

  /// Check member is Exist by groupId, userDocId.
  static Future<bool> checkMemberIsExist({
    required String groupId,
    required String userDocId,
  }) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .where('user_id', isEqualTo: userDocId)
          .get();

      if (snapshot.docs.isEmpty) {
        return false;
      }

      return snapshot.docs.any((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        return data != null;
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to check member. $e');
    }
  }

  /// Watch all member's profiles with 'groupId'.
  static Stream<List<UserProfile?>> watchAllUserProfileWithGroupId(
    String groupId,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .snapshots();

      await for (final snapshot in stream) {
        yield await _fetchUserProfileList(snapshot: snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user profile list. $e');
    }
  }

  /// Watch all role(Selected 'admin', or 'membership')
  /// member's profiles.
  static Stream<List<UserProfile?>> watchAllUserProfileWithGroupIdAndRole(
    String groupId,
    String role,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('group_id', isEqualTo: groupId)
          .where('role', isEqualTo: role)
          .snapshots();

      await for (final snapshot in stream) {
        yield await _fetchUserProfileList(snapshot: snapshot, role: role);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch user profile list. $e');
    }
  }

  static Future<List<UserProfile?>> _fetchUserProfileList({
    required QuerySnapshot<Map<String, dynamic>> snapshot,
    String? role,
  }) async {
    return Future.wait(
      snapshot.docs.map((doc) async {
        final userDocId = doc.data()['user_id'] as String?;
        if (userDocId == null) {
          debugPrint('No found $role document data.');
          return null;
        }
        return _readUserProfile(userDocId);
      }).toList(),
    );
  }

  static Future<UserProfile> _readUserProfile(String userId) async {
    return UserController.read(userId);
  }

  static Stream<List<GroupMembership?>> watchAllWithUserId(
    String userDocId,
  ) async* {
    try {
      final stream = db
          .collection(collectionPath)
          .where('user_id', isEqualTo: userDocId)
          .snapshots();

      await for (final snapshot in stream) {
        yield _fetchGroupMembershipList(snapshot);
      }
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to watch group member list. $e');
    }
  }

  static List<GroupMembership?> _fetchGroupMembershipList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        debugPrint('Error : No found document data.');
        return null;
      }

      if (data['created_at'] == null) {
        return null;
      }

      return GroupMembership.fromMap(data);
    }).toList();
  }

  /// Read specified member.
  static Future<GroupMembership> read(String docId) async {
    try {
      final memberDoc = await db.collection(collectionPath).doc(docId).get();
      final data = memberDoc.data();
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      return GroupMembership.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch group membership. $e');
    }
  }

  /// Update membership users
  static Future<void> update({
    required String docId,
    required String userId,
    required String username,
    required String? userDescription,
    required String role,
    required String groupId,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'user_id': userId,
        'username': username,
        'user_description': userDescription,
        'role': role,
        'group_id': groupId,
        'updated_at': FieldValue.serverTimestamp() as Timestamp,
      };
      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update group member database. $e');
    }
  }

  /// Delete specified member.
  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group member. $e');
    }
  }
}
