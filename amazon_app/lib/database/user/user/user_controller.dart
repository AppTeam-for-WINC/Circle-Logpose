import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'user.dart';

class UserController {
  const UserController();

  static final db = FirebaseFirestore.instance;
  static final storageRef = FirebaseStorage.instance.ref();
  // static final storage = FirebaseStorage.instanceFor(bucket: "gs://fir-15300.appspot.com");

  static const collectionPath = 'users';


  static Future<String?> uploadUserImageToStorage(String image) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imagesRef = storageRef.child('images/users');
      final upload = imagesRef.putFile(imageFile, metadata);

      await upload.whenComplete(() => null);
      final downloadURL = await imagesRef.getDownloadURL();
      debugPrint('Success to upload image file: $downloadURL');

      return downloadURL;
    } on FirebaseException catch (e) {
      debugPrint('Error: Failed to upload image file. $e');
      return null;
    }
  }


  // static Future<String?> getUserImageFromStorage(String fileName) async {
  //   final Reference? imagesRef = storageRef.child('user_images');

  //   if (imagesRef == null) {
  //     return null;
  //   }
  //   final imagePath = imagesRef.child(fileName).fullPath;
  //   return imagePath;
  // }


  static Future<void> create(
    {
      required String userId, 
      required String email,
      String? name,
      String? image,
    }
  ) async{
    final doc = db.collection(collectionPath).doc(userId);

    await doc.set({
      'document_id': userId,
      'name': name,
      'image': image,
      'email': email,
    });
  }

  static Future<UserProfile> read(String documentId) async {
    final snapshot = await db.collection(collectionPath).doc(documentId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception('documentId not found.');
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
      documentId: documentId,
      name: name,
      image: image,
      email: email,
    );
  }

  ///メールアドレスの変更機能はこの関数では行わない。
  static Future<void> update(
    String documentId,
    String name, 
    String image, 
  ) async {
    final updateData = <String, dynamic>{
      'name': name,
      'image': image,
    };

    await db.collection(collectionPath).doc(documentId).update(updateData);
  }

  ///テーブルはこの関数で削除できるが、authenticationには反映されない。
  static Future<void> delete(String documentId) async {
    await db.collection(collectionPath).doc(documentId).delete();
  }

}
