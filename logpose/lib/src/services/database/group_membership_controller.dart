import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/group/database/group_membership.dart';
import '../../models/user/user.dart';
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
    final groupMembershipDoc = db.collection(collectionPath).doc();
    final userDoc = await db.collection('users').doc(userDocId).get();
    final userRef = userDoc.data();
    if (userRef == null) {
      throw Exception('Error : No found document data.');
    }

    final username = userRef['name'] as String;
    final userDescription = userRef['description'] as String?;
    final joinedAt = FieldValue.serverTimestamp();

    await groupMembershipDoc.set({
      'user_id': userDocId,
      'username': username,
      'user_description': userDescription,
      'group_id': groupId,
      'role': role,
      'created_at': joinedAt,
    });
  }

  /// Read all memgber's doc ID.
  static Future<List<String>> readAllUserDocIdWithGroupId(
    String groupId,
  ) async {
    final groupMembershipSnapshot = await db
        .collection(collectionPath)
        .where('group_id', isEqualTo: groupId)
        .get();

    final userDocIds = groupMembershipSnapshot.docs.map((doc) {
      final groupMembershipRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipRef == null) {
        throw Exception('No found document data.');
      }
      final userDocId = groupMembershipRef['user_id'] as String;
      return userDocId;
    }).toList();

    return userDocIds;
  }

  /// Watch all memgber's doc ID.
  static Stream<List<String?>> watchAllUserDocIdWithGroupIdStream(
    String groupId,
  ) async* {
    final groupMemberStream = db
        .collection(collectionPath)
        .where('group_id', isEqualTo: groupId)
        .snapshots();

    await for (final groupMembers in groupMemberStream) {
      final userDocIds = groupMembers.docs.map((doc) {
        final groupMembershipData = doc.data() as Map<String, dynamic>?;
        if (groupMembershipData == null) {
          throw Exception('No found document data.');
        }
        final userDocId = groupMembershipData['user_id'] as String;
        return userDocId;
      }).toList();

      yield userDocIds;
    }
  }

  /// Check member is Exist by groupId, userDocId.
  static Future<bool> checkMemberIsExist({
    required String groupId,
    required String userDocId,
  }) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('group_id', isEqualTo: groupId)
        .where('user_id', isEqualTo: userDocId)
        .get();

    if (snapshot.docs.isEmpty) {
      return false;
    }

    return snapshot.docs.any((doc) {
      final memberProfileData = doc.data() as Map<String, dynamic>?;
      return memberProfileData != null;
    });
  }

  /// Read all role(Please selected 'admin', or 'membership') member's profiles.
  static Stream<List<UserProfile?>> readAllRoleByProfileWithGroupId(
    String groupId,
    String role,
  ) async* {
    final groupMemberStream = db
        .collection(collectionPath)
        .where('group_id', isEqualTo: groupId)
        .where('role', isEqualTo: role)
        .snapshots();

    await for (final groupMembers in groupMemberStream) {
      final groupMemberRefsFuture = groupMembers.docs.map((doc) async {
        final groupMemberDocRef = doc.data() as Map<String, dynamic>?;
        if (groupMemberDocRef == null) {
          debugPrint('No found $role document data.');
          return null;
        }

        final userId = groupMemberDocRef['user_id'] as String;
        return UserController.read(userId);
      }).toList();
      final groupMemberRefs = await Future.wait(groupMemberRefsFuture);

      yield groupMemberRefs;
    }
  }

  static Stream<List<GroupMembership?>> readAllWithUserId(
    String userDocId,
  ) async* {
    final groupMembershipsStream = db
        .collection(collectionPath)
        .where('user_id', isEqualTo: userDocId)
        .snapshots();

    await for (final groupMemberships in groupMembershipsStream) {
      final groupMembershipsRefs = groupMemberships.docs.map((doc) {
        final groupMembershipDocRef = doc.data() as Map<String, dynamic>?;
        if (groupMembershipDocRef == null) {
          debugPrint('Error : No found document data.');
          return null;
        }

        final userId = groupMembershipDocRef['user_id'] as String;
        final username = groupMembershipDocRef['username'] as String;
        final userDescription =
            groupMembershipDocRef['user_description'] as String?;
        final role = groupMembershipDocRef['role'] as String;
        final groupId = groupMembershipDocRef['group_id'] as String;
        final updatedAt = groupMembershipDocRef['updated_at'] as Timestamp?;
        final joinedAt = groupMembershipDocRef['created_at'] as Timestamp?;
        if (joinedAt == null) {
          return null;
        }
        return GroupMembership(
          userId: userId,
          username: username,
          userDescription: userDescription,
          role: role,
          groupId: groupId,
          updatedAt: updatedAt,
          joinedAt: joinedAt,
        );
      }).toList();

      yield groupMembershipsRefs;
    }
  }

  /// Read specified member.
  static Future<GroupMembership> read(String docId) async {
    final groupMembershipDoc =
        await db.collection(collectionPath).doc(docId).get();
    final groupMembershipDocRef = groupMembershipDoc.data();
    if (groupMembershipDocRef == null) {
      throw Exception('Error : No found document data.');
    }

    return GroupMembership.fromMap(groupMembershipDocRef);
  }

  ///後で、ユーザー名、ユーザーの説明、ユーザーのロール其々を個別で変更できるような関数を作る。
  ///Update membership users
  static Future<void> update({
    required String docId,
    required String userId,
    required String username,
    required String? userDescription,
    required String role,
    required String groupId,
  }) async {
    final updatedAt = FieldValue.serverTimestamp() as Timestamp;

    final updateData = <String, dynamic>{
      'user_id': userId,
      'username': username,
      'user_description': userDescription,
      'role': role,
      'group_id': groupId,
      'updated_at': updatedAt,
    };
    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  ///Delete specified member.
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
