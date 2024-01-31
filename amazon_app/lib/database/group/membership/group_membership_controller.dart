import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'group_membership.dart';

class GroupMembershipController {
  const GroupMembershipController();
  static final db = FirebaseFirestore.instance;

  static const collectionPath = 'group_memberships';

  //グループ作成時に作成者用に自動で呼び出すようにしなければならない。
  ///Added the group to new member.
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

  ///Read specified member.
  static Future<GroupMembership> read(String docId) async {
    final groupMembershipDoc =
        await db.collection(collectionPath).doc(docId).get();
    final groupMembershipDocRef = groupMembershipDoc.data();
    if (groupMembershipDocRef == null) {
      throw Exception('Error : No found document data.');
    }

    final userId = groupMembershipDocRef['user_id'] as String;
    final username = groupMembershipDocRef['username'] as String;
    final userDescription =
        groupMembershipDocRef['user_description'] as String?;
    final role = groupMembershipDocRef['role'] as String;
    final groupId = groupMembershipDocRef['group_id'] as String;
    final updatedAt = groupMembershipDocRef['updated_at'] as Timestamp?;
    final joinedAt = groupMembershipDocRef['created_at'] as Timestamp;

    return GroupMembership(
      userId: userId,
      username: username,
      userDescription: userDescription,
      role: role,
      groupId: groupId,
      updatedAt: updatedAt,
      joinedAt: joinedAt,
    );
  }

  ///後で、factoryメソッドを使って、ユーザー名、ユーザーの説明、ユーザーのロール其々を個別で変更できるような関数を作る。
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

  static Stream<void> watch() async* {}
}
