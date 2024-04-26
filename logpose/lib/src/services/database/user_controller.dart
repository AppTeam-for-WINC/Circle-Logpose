import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../common/error_messages.dart';
import '../../models/database/user/user.dart';
import '../storage/storage.dart';

class UserController {
  // Hoge constructor
  UserController._internal();
  static final UserController _instance = UserController._internal();
  static UserController get instance => _instance;

  static final db = FirebaseFirestore.instance;
  static const uuid = Uuid();
  static const collectionPath = 'users';

  static Future<void> create({
    required String docId,
    String? accountId,
    String? name,
    String? image,
    String? description,
  }) async {
    try {
      while (true) {
        final snapshot = await db
            .collection(collectionPath)
            .where('account_id', isEqualTo: accountId)
            .get();
        accountId = uuid.v4();
        if (snapshot.docs.isEmpty) {
          break;
        }
      }

      String? imagePath = 'src/images/group_img.jpeg';
      if (image != null) {
        imagePath =
            await StorageController.uploadUserImageToStorage(docId, image);
      }

      await db.collection(collectionPath).doc(docId).set({
        'account_id': accountId,
        'name': name,
        'image': imagePath,
        'description': description,
        'created_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to create user account. $e');
    }
  }

  static Future<UserProfile> read(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw ControllerException(DBErrorMessages.userNotFound + docId);
      }

      return UserProfile.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. $e');
    }
  }

  /// Read userProfile's list with accountId.
  static Future<List<UserProfile>> readWithAccountIdList(
    String accountId,
  ) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw ControllerException(DBErrorMessages.noDocumentData + accountId);
        }
        return UserProfile.fromMap(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile list. $e');
    }
  }

  /// Read userProfile with accountId.
  static Future<UserProfile?> readWithAccountId(String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return _fetchUserProfile(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch accountId. $e');
    }
  }

  static UserProfile? _fetchUserProfile(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;
          if (data == null) {
            return null;
          }

          return UserProfile.fromMap(data);
        })
        .whereType<UserProfile>()
        .firstOrNull;
  }

  /// Read userDocId with accountId.
  static Future<String> readUserDocIdWithAccountId(String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isEmpty) {
        throw ControllerException(
          DBErrorMessages.userAccountNotFound + accountId,
        );
      }
      final data = snapshot.docs.first.data() as Map<String, dynamic>?;
      if (data == null) {
        throw ControllerException(DBErrorMessages.noDocumentData);
      }

      return snapshot.docs.first.id;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch UserDocId. $e');
    }
  }

  static Future<void> update(
    String docId,
    String? name,
    String? image,
    String? description,
  ) async {
    try {
      final updateData = <String, dynamic>{
        'updated_at': FieldValue.serverTimestamp(),
      };
      if (name != null) {
        updateData['name'] = name;
      }
      if (image != null) {
        final imagePath =
            await StorageController.uploadUserImageToStorage(docId, image);
        if (imagePath != null) {
          updateData['image'] = imagePath;
        }
      }
      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user profile. $e');
    }
  }

  static Future<bool> updateAccountId(String docId, String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        debugPrint('The account ID is already used');
        return false;
      }

      final updateData = <String, String>{
        'account_id': accountId,
      };

      await db.collection(collectionPath).doc(docId).update(updateData);
      return true;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update accountId. $e');
    }
  }

  ///テーブルはこの関数で削除できるが、authenticationには反映されない。
  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to delete user profile table. $e');
    }
  }
}
