import 'package:amazon_app/database/utils/error_messages.dart';
import 'package:amazon_app/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'user.dart';

class UserController {
  //Hoge constructor
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
    final doc = db.collection(collectionPath).doc(docId);

    while (true) {
      final userSnapshot = await db
          .collection(collectionPath)
          .where('account_id', isEqualTo: accountId)
          .get();
      accountId = uuid.v4();

      if (userSnapshot.docs.isEmpty) {
        break;
      }
    }

    String? imagePath;
    if (image == null) {
      imagePath = 'src/images/group_img.jpeg';
    } else {
      imagePath =
          await StorageController.uploadUserImageToStorage(docId, image);
    }

    final createdAt = FieldValue.serverTimestamp();

    await doc.set({
      'account_id': accountId,
      'name': name,
      'image': imagePath,
      'description': description,
      'created_at': createdAt,
    });
  }

  static Future<UserProfile> read(String docId) async {
    final userDoc = await db.collection(collectionPath).doc(docId).get();
    final userRef = userDoc.data();
    if (userRef == null) {
      throw ControllerException(DBErrorMessages.userNotFound + docId);
    }

    return UserProfile.fromMap(userRef);
  }

  static Future<List<UserProfile>> readWithAccountId(String accountId) async {
    final userSnapshot = await db
        .collection(collectionPath)
        .where('account_id', isEqualTo: accountId)
        .get();

    final userRefs = userSnapshot.docs.map((doc) {
      final userDocRef = doc.data() as Map<String, dynamic>?;
      if (userDocRef == null) {
        throw ControllerException(DBErrorMessages.noDocumentData + accountId);
      }
      return UserProfile.fromMap(userDocRef);
    }).toList();

    return userRefs;
  }

  static Future<String> readUserDocIdWithAccountId(String accountId) async {
    final userSnapshot = await db
        .collection(collectionPath)
        .where('account_id', isEqualTo: accountId)
        .get();

    if (userSnapshot.docs.isEmpty) {
      throw ControllerException(DBErrorMessages.userAccountNotFound + accountId);
    }

    final userDoc = userSnapshot.docs.first;
    final userDocRef = userDoc.data() as Map<String, dynamic>?;

    if (userDocRef == null) {
      throw ControllerException(DBErrorMessages.noDocumentData);
    }

    return userDoc.id;
  }

  ///メールアドレスとaccountIdの変更機能はこの関数では行わない。
  static Future<void> update(
    String docId,
    String? name,
    String? image,
    String? description,
  ) async {
    final updatedAt = FieldValue.serverTimestamp();
    final updateData = <String, dynamic>{'updated_at': updatedAt};

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
  }

  static Future<bool> updateAccountId(String docId, String accountId) async {
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
    debugPrint('Successfully changed account ID');
    return true;
  }

  ///テーブルはこの関数で削除できるが、authenticationには反映されない。
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
