import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../exceptions/group/group_setting_exception.dart';
import '../../../models/database/group/group_profile.dart';
import '../storage/storage_repository.dart';

/// Stream型をwatchもしくはlistenで書く。
/// Future型はreadもしくは　fetchで書く。

class GroupRepository {
  // シングルトンパターンにしています。
  GroupRepository._internal();
  static final GroupRepository _instance = GroupRepository._internal();
  static GroupRepository get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const collectionPath = 'groups';

  /// Create Group database, return Group Doc ID.
  Future<String> create(
    String name,
    String? image,
    String? description,
  ) async {
    try {
      // Create new document
      final groupDoc = db.collection(collectionPath).doc();

      String? imagePath;
      if (image == '') {
        imagePath = await _downloadGroupDefaultImageToStorage();
      } else if (image != null) {
        imagePath = await _uploadGroupImageToStorage(groupDoc.id, image);
      } else {
        throw Exception('Error: failed to set group data.');
      }

      // Get server time.
      /// ここで createdAt変数に敢えて格納することで、 serverTimestampの取得処理時間を獲得できる。
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

  static Future<String> _downloadGroupDefaultImageToStorage() async {
    return StorageRepository.downloadGroupDefaultImageToStorage();
  }

  static Future<String> _uploadGroupImageToStorage(
    String groupDocId,
    String image,
  ) async {
    return StorageRepository.uploadGroupImageToStorage(
      groupDocId,
      image,
    );
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

  /// Watch the group database.
  static Stream<GroupProfile?> watch(String docId) {
    return db.collection(collectionPath).doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('Error : No found document data.');
      }

      return GroupProfile.fromMap(snapshot.data()!);
    });
  }

  /// Fetch the group database.
  Future<GroupProfile> fetchGroup(String docId) async {
    try {
      final snapshot = await db.collection(collectionPath).doc(docId).get();
      final data = snapshot.data();

      if (data == null) {
        throw Exception('Error: No data found for document ID $docId');
      }

      return GroupProfile.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch Group. ${e.message}');
    }
  }

  /// Update group database
  Future<void> update({
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

      if (image != '') {
        updateData['image'] =
            await StorageRepository.uploadGroupImageToStorage(docId, image!);
      }

      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw GroupUpdateException('Error: failed to update group. ${e.message}');
    }
  }

  /// 後でcloud functionsに設定させる。（セキュリティ的な問題のため！）
  /// Delete group
  Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete group. $e');
    }
  }
}
