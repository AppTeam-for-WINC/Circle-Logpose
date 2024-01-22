import 'package:amazon_app/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'group.dart';

class GroupController {
  const GroupController();

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'groups';

  ///Create group database.
  static Future<void> create(
    String name,
    String? image,
    String? description,
  ) async {
    ///Create new document
    final groupDoc = db.collection(collectionPath).doc();

    String? imagePath;
    if (image == null) {
      imagePath = 'amazon_app/images/group_img.jpeg';
    } else {
      imagePath =
          await StorageController.uploadUserImageToStorage(groupDoc.id, image);
    }

    ///Get server time
    final createdAt = FieldValue.serverTimestamp();

    await groupDoc.set({
      'name': name,
      'image': imagePath,
      'description': description,
      'updated_at': null,
      'created_at': createdAt,
    });
  }

  ///Read all members.
  static Future<List<Group>> readAll(String userId) async {
    final groups = await db
        .collection(collectionPath)
        .where('user_id', isEqualTo: userId)
        .get();
    final groupMembershipsRefs = groups.docs.map((doc) {
      final groupMembershipsRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipsRef == null) {
        throw Exception('Error : No found document data.');
      }

      final name = groupMembershipsRef['name'] as String;
      final description = groupMembershipsRef['descrption'] as String?;
      final image = groupMembershipsRef['image'] as String;
      final updatedAt = groupMembershipsRef['updated_at'] as Timestamp?;
      final createdAt = groupMembershipsRef['created_at'] as Timestamp;

      return Group(
        name: name,
        description: description,
        image: image,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
    }).toList();

    return groupMembershipsRefs;
  }

  static Future<List<String>> readAllDocId(String userId) async {
    final groups = await db
        .collection(collectionPath)
        .where('user_id', isEqualTo: userId)
        .get();
    final groupMembershipsRefs = groups.docs.map((doc) {
      final groupMembershipsRef = doc.data() as Map<String, dynamic>?;
      if (groupMembershipsRef == null) {
        throw Exception('Error : No found document data.');
      }

      return doc.id;
    }).toList();

    return groupMembershipsRefs;
  }

  ///Get the group database.
  static Future<Group> read(String docId) async {
    final groupDoc = await db.collection(collectionPath).doc(docId).get();
    final groupDocRef = groupDoc.data();
    if (groupDocRef == null) {
      throw Exception('Error : No found document data.');
    }

    final name = groupDocRef['name'] as String;
    final description = groupDocRef['descrption'] as String?;
    final image = groupDocRef['image'] as String;
    final updatedAt = groupDocRef['updated_at'] as Timestamp?;
    final createdAt = groupDocRef['created_at'] as Timestamp;

    return Group(
      name: name,
      description: description,
      image: image,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  ///後で、アップデート機能をfactoryにして、名前、説明、画像其々個別で変更できるような関数を作成する。
  ///Update group database
  static Future<void> update({
    required String docId,
    required String name,
    required String? description,
    required String image,
  }) async {
    final imagePath =
        await StorageController.uploadGroupImageToStorage(docId, image);
    if (imagePath == null) {
      return;
    }

    final updatedAt = FieldValue.serverTimestamp();

    final updateData = <String, dynamic>{
      'name': name,
      'description': description,
      'image': imagePath,
      'updated_at': updatedAt,
    };
    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  ///後でcloud functionsに設定させる。（セキュリティ的な問題のため！）
  ///Delete group
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
