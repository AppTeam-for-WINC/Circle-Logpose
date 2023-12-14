import 'package:cloud_firestore/cloud_firestore.dart';

import 'group_membership.dart';

class GroupMembershipController {
  const GroupMembershipController();
  static final db = FirebaseFirestore.instance;

  static const collectionPath = 'group_memberships';

  static Future<void> create({
    required String groupId,
    required String userId,
  }) async {
    final doc = db.collection(collectionPath).doc();
    
    await doc.set({
      'group_id': groupId,
      'user_id': userId,
    });
  }

  static Future<List<GroupMembership>> readAll(String groupId) async {
    final snapshot = await db.collection(collectionPath).get();

    final groupMemberships = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      final userId = data['user_id'] as String;
      
      return GroupMembership(
        documentId: doc.id,
        userId: userId,
        groupId: groupId,
      );
    }).toList();

    return groupMemberships;
  }

  static Future<void> deleteAll(String groupId) async {
    final snapshot = await db.collection(collectionPath)
    .where('group_id', isEqualTo: groupId)
    .get();
    
    for (final doc in snapshot.docs) {
      await db.collection(collectionPath).doc(doc.id).delete();
    }
  }

  static Future<void> delete(String groupId, String userId) async {
   final snapshot = await db.collection(collectionPath)
    .where('group_id', isEqualTo: groupId)
    .where('user_id', isEqualTo: userId)
    .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('Error: Document ID not found');
    }
    await db.collection(collectionPath).doc(snapshot.docs.first.id).delete();
  }

  static Stream<void> watch() async* {

  }
}
