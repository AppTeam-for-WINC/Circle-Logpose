import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'group.dart';

class GroupController {
  const GroupController();

  static final db = FirebaseFirestore.instance;
  static const uuid =  Uuid();
  static const collectionPath = 'groups';

  ///Create group database.
  ///Return created group document ID.
  static Future<void> create(
    String name, String image,
  ) async {
    ///Create new document ID
    final doc = db.collection(collectionPath).doc();

    ///Create new membershipkey
    final membershipKey = uuid.v4();

    ///Create new adminkey
    final adminKey = uuid.v4();

    ///Get server time
    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'name': name,
      'image': image,
      'membership_key': membershipKey,
      'admin_key': adminKey,
      'created_at': createdAt,
    });
  }

  ///Get all group database
  static Future<List<Group>> readAll() async {
    final QuerySnapshot snapshot = await db.collection(collectionPath).get();

    final groups = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('Error : No found document data.');
      }

      final name = data['name'] as String;
      final image = data['image'] as String;
      final createdAt = data['created_at'] as DateTime?;

      return Group(
        documentId: doc.id,
        name: name,
        image: image,
        createdAt: createdAt,
      );
    }).toList();

    return groups;
  }

  ///セキュリティ度外視で　この関数のみ membership_key, admin_keyを返しています。
  ///Get group database.
  static Future<Group> read(String documentId) async {
    final snapshot = await db.collection(collectionPath).doc(documentId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not founded.');
    }

    final name = data['name'] as String;
    final image = data['image'] as String;
    final membershipKey = data['membership_key'] as String;
    final adminKey = data['admin_key'] as String;
    final createdAt = data['created_at'] as DateTime?;

    return Group(
      documentId: documentId,
      name: name,
      image: image,
      membershipKey: membershipKey,
      adminKey: adminKey,
      createdAt: createdAt,
    );
  }

  ///Update group imformation
  static Future<void> updateGroup({
    required String documentId,
    required String name,
    required String image,
  }) async {
    final updateData = <String, dynamic>{
      'name': name,
      'image': image,
    };
    await db.collection(collectionPath).doc(documentId).update(updateData);
  }

  ///Delete group
  static Future<void> delete(String documentId) async {
    await db.collection(collectionPath).doc(documentId).delete();
  }
}
