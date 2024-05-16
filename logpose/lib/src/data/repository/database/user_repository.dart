import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../../../exceptions/user/user_exception.dart';
import '../../../common/error_messages.dart';
import '../../../models/database/user/user.dart';
import '../storage/storage_repository.dart';

class UserRepository {
  // Hoge constructor
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  static UserRepository get instance => _instance;

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

      String? imagePath;
      if (image == '') {
        imagePath = await _downloadUserDefaultImageToStorage();
      } else if (image != null) {
        imagePath = await _uploadUserImageToStorage(docId, image);
      } else {
        throw Exception('Error: failed to set user data.');
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

  static Future<String> _downloadUserDefaultImageToStorage() async {
    return StorageRepository.downloadUserDefaultImageToStorage();
  }

  static Future<String> _uploadUserImageToStorage(
    String userDocId,
    String image,
  ) async {
    return StorageRepository.uploadUserImageToStorage(
      userDocId,
      image,
    );
  }

  /// Fetch user database.
  Future<UserProfile> fetch(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw RepositoryException(DBErrorMessages.userNotFound + docId);
      }

      return UserProfile.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  /// To-do delete.
  static Future<UserProfile> fetchWithStatic(String docId) async {
    try {
      final data =
          (await db.collection(collectionPath).doc(docId).get()).data();
      if (data == null) {
        throw RepositoryException(DBErrorMessages.userNotFound + docId);
      }

      return UserProfile.fromMap(data);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. ${e.message}');
    }
  }

  /// Watch(Listen) user database.
  static Stream<UserProfile?> watch(String docId) {
    try {
      return db
          .collection(collectionPath)
          .doc(docId)
          .snapshots()
          .map((snapshot) {
        if (!snapshot.exists) {
          throw Exception('Error : No found document data.');
        }

        return UserProfile.fromMap(snapshot.data()!);
      });
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user profile. $e');
    }
  }

  /// Read userProfile with accountId.
  Future<UserProfile?> fetchUserProfileWithAccountId(
    String accountId,
  ) async {
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
  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    try {
      final snapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();

      if (snapshot.docs.isEmpty) {
        throw RepositoryException(
          DBErrorMessages.userAccountNotFound + accountId,
        );
      }
      final data = snapshot.docs.first.data() as Map<String, dynamic>?;
      if (data == null) {
        throw RepositoryException(DBErrorMessages.noDocumentData);
      }

      return snapshot.docs.first.id;
    } on FirebaseException catch (e) {
      throw UserException('Error: failed to fetch user ID. ${e.message}');
    }
  }

  Future<void> updateUser(
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
      if (image != '') {
        updateData['image'] =
            await StorageRepository.uploadUserImageToStorage(docId, image!);
      }
      if (description != null) {
        updateData['description'] = description;
      }

      await db.collection(collectionPath).doc(docId).update(updateData);
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to update user profile. ${e.message}');
    }
  }

  Future<bool> updateAccountId(String docId, String accountId) async {
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
      throw Exception('Error: failed to update accountId. ${e.message}');
    }
  }

  ///テーブルはこの関数で削除できるが、authenticationには反映されない。
  static Future<void> delete(String docId) async {
    try {
      await db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        'Error: failed to delete user profile table. ${e.message}',
      );
    }
  }
}
