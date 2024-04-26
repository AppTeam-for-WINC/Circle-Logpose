import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/database/group/group_profile.dart';

import '../storage/storage.dart';

/// Stream型をwatchで書く。
/// Future型はreadで書く。

class GroupController {
  // シングルトンパターンにしています。
  GroupController._internal();
  static final GroupController _instance = GroupController._internal();
  static GroupController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'groups';

  /// Create Group database, return Group Doc ID.
  static Future<String> create(
    String name,
    String? image,
    String? description,
  ) async {
    try {
      // Create new document
      final groupDoc = db.collection(collectionPath).doc();

      String? imagePath = 'src/images/group_img.jpeg';
      if (image != null) {
        imagePath = await StorageController.uploadGroupImageToStorage(
          groupDoc.id,
          image,
        );
      }

      // Get server time
      final createdAt = FieldValue.serverTimestamp();

      // Set database.
      await groupDoc.set({
        'name': name,
        'image': imagePath,
        'description': description,
        'updated_at': null,
        'created_at': createdAt,
      });

      return groupDoc.id;
    } on FirebaseException catch (e) {
      throw Exception('Failed to create group document: $e');
    }
  }

  static Future<List<String>> readAllDocId(String userId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('user_id', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch Group ID list. $e');
    }
  }

  /// Get the group database.
  static Stream<GroupProfile?> watch(String docId) {
    return db.collection(collectionPath).doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('Error : No found document data.');
      }

      return GroupProfile.fromMap(snapshot.data()!);
    });
  }

  /// Fetch the group database.
  static Future<GroupProfile?> read(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();
      if (data == null) {
        return null;
      }

      return GroupProfile.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch Group. $e');
    }
  }

  /// Update group database
  static Future<void> update({
    required String docId,
    required String? name,
    required String? description,
    required String? image,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'updated_at': FieldValue.serverTimestamp(),
      };

      if (name != null) {
        updateData['name'] = name;
      }

      if (image != null) {
        final imagePath =
            await StorageController.uploadGroupImageToStorage(docId, image);
        if (imagePath != null) {
          updateData['image'] = imagePath;
        }
      }

      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update group database. $e');
    }
  }

  /// 後でcloud functionsに設定させる。（セキュリティ的な問題のため！）
  /// Delete group
  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. $e');
    }
  }
}
