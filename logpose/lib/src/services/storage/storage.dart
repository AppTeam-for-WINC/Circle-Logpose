import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageController {
  const StorageController();
  static final storage = FirebaseStorage.instance.ref();

  static Future<String> uploadUserImageToStorage(
    String userId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference('users', userId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  static Future<String> uploadGroupImageToStorage(
    String groupId,
    String image,
  ) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/*');
      final imageFile = File(image);
      final imageRef = _setReference('groups', groupId, imageFile.path);
      final uploadFile = _uploadFile(imageRef, imageFile, metadata);
      await _whenComplete(uploadFile);

      return await _getDownloadURL(imageRef);
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  /// Folder is 'groups' or 'users'.
  static Reference _setReference(
    String folder,
    String docId,
    String path,
  ) {
    return storage.child('images/$folder/$docId/$path');
  }

  static UploadTask _uploadFile(
    Reference imagesRef,
    File imageFile,
    SettableMetadata metadata,
  ) {
    return imagesRef.putFile(imageFile, metadata);
  }

  static Future<void> _whenComplete(UploadTask uploadFile) async {
    await uploadFile.whenComplete(() => null);
  }

  static Future<String> _getDownloadURL(Reference imageRef) async {
    return imageRef.getDownloadURL();
  }

  static Future<String> downloadGroupDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_group_jpg.png',
      );
      return gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }

  static Future<String> downloadUserDefaultImageToStorage() async {
    try {
      final gsReference = FirebaseStorage.instance.refFromURL(
        'gs://fir-15300.appspot.com/images/default/default_user.png',
      );
      return gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Error: Failed to upload image file. $e');
    }
  }
}
