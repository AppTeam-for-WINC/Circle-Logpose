import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageController {
  const StorageController();
  static final storage = FirebaseStorage.instance.ref();

  static Future<String?> uploadUserImageToStorage(
      String userId, String image,) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageName = imageFile.toString();
      final imagesRef = storage.child('images/users/$userId/$imageName');
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

  static Future<String?> uploadGroupImageToStorage(
      String groupId, String image,) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageName = imageFile.toString();
      final imagesRef = storage.child('images/groups/$groupId/$imageName');
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
}
