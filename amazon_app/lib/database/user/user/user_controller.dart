import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class UserController {
  const UserController();

  static final db = FirebaseFirestore.instance;

  static const collectionPath = 'users';

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

  static Future<UserDB> read(String documentId) async {
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

    return UserDB(
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
    String email,) 
  async {
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
