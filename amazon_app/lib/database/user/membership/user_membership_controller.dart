import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_membership.dart';

class UserMembershipController {
  const UserMembershipController();

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'user_memberships';

  static Future<void> create(String userId, String groupId) async {
    final doc = db.collection(collectionPath).doc();
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'document_id': doc.id,
      'user_id': userId,
      'group_id': groupId,
      'created_at': createdAt,
    });
  }

  static Future<List<UserMembership>> readAll() async {
    final QuerySnapshot snapshot = await db.collection(collectionPath).get();

    final userMemberships = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      final userId = data['user_id'] as String;
      final groupId = data['group_id'] as String;
      final createdAt = data['created_at'] as DateTime?;

      return UserMembership(
        documentId: doc.id,
        userId: userId,
        groupId: groupId,
        createdAt: createdAt,
      );
    }).toList();

    return userMemberships;
  }

  static Future<UserMembership> read(String documentId) async {
    final snapshot = await db.collection(collectionPath).doc(documentId).get();

    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not found');
    }

    final userId = data['user_id'] as String;
    final groupId = data['group_id'] as String;

    return UserMembership(
      documentId: documentId,
      userId: userId,
      groupId: groupId,
    );
  }

  static Future<void> delete(String documentId) async {
    await db.collection(collectionPath).doc(documentId).delete();
  }
}
