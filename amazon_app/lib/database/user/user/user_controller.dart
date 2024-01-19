import 'package:amazon_app/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'user.dart';

class UserController {
  const UserController();

  static final db = FirebaseFirestore.instance;
  static const uuid = Uuid();
  static const collectionPath = 'users';

  static Future<void> create({
    required String docId,
    String? userId,
    required String email,
    String? name,
    String? image,
  }) async {
    final doc = db.collection(collectionPath).doc(docId);

    final snapshot = await db
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .get();

    while (true) {
      userId = uuid.v4();
      if (snapshot.docs.isEmpty) {
        break;
      }
    }

    String? imagePath;
    if (image != null) {
      imagePath =
          await StorageController.uploadUserImageToStorage(docId, image);
    }

    await doc.set({
      'userId': userId,
      'name': name,
      'image': imagePath,
      'email': email,
    });
  }

  static Future<UserProfile> read(String docId) async {
    final snapshot = await db.collection(collectionPath).doc(docId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not found.');
    }

    var userId = data['userId'];
    if (userId is! String) {
      userId = userId.toString();
    }

    var name = data['name'];
    if (name is! String) {
      name = name.toString();
    }

    var image = data['image'];
    if (image is! String) {
      image = image.toString();
    }

    var email = data['email'];
    if (email is! String) {
      email = email.toString();
    }

    return UserProfile(
      docId: docId,
      name: name,
      image: image,
      email: email,
    );
  }

  ///メールアドレスとuserIdの変更機能はこの関数では行わない。
  static Future<void> update(
    String docId,
    String name,
    String image,
  ) async {
    final imagePath =
        await StorageController.uploadUserImageToStorage(docId, image);
    if (imagePath == null) {
      return;
    }
    final updateData = <String, String>{
      'name': name,
      'image': imagePath,
    };

    await db.collection(collectionPath).doc(docId).update(updateData);
  }

  static Future<bool> updateUserId(String docId, String userId) async {
    final snapshot = await db
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      debugPrint('The user ID is already used');
      return false;
    }
    
    final updateData = <String, String>{
      'userId': userId,
    };

    await db.collection(collectionPath).doc(docId).update(updateData);
    debugPrint('Successfully changed user ID');
    return true;
  }

  ///テーブルはこの関数で削除できるが、authenticationには反映されない。
  static Future<void> delete(String docId) async {
    await db.collection(collectionPath).doc(docId).delete();
  }
}
