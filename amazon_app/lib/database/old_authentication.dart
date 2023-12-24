// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'riverpod.dart';

import 'user/user/user_controller.dart';

///How to manage email.
///https://www.notion.so/Email-c2a0c4f50a064bd09df0ce93b5b5ae61?pvs=4


Future<bool> createAccount(String email, String password) async {
  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userId = userCredential.user?.uid ?? '';
    if (userId == '') {
      debugPrint('Error: Failed to create account.');
      return false;
    }
    
    await UserController.create(userId: userId, email: email);
    debugPrint('アカウントの作成に成功しました。 $userId');
    return true;
  } on FirebaseAuthException catch (error) {
    debugPrint('アカウントの作成中にエラーが発生しました: $error');
    return false;
  }
}


Future<bool> loginUser(String email, String password) async {
  try {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('ログイン成功');
    return true;
  } catch (error) {
    print('ログイン中にエラーが発生しました: $error');
    return false;
  }
}


// // 以下はデータを取得する関数
// // getDocumentData(コレクション(user_info or group_info or Schedule_info),docId(user.uid or primaryGropuId))でMap型のデータを取得できる。
// // user.uidは登録したユーザーの固有のID
// Future<Map<String, dynamic>?> getDocumentData(
//     String collectionName, String docId, WidgetRef ref) async {
//       final firestore = ref.watch(firestoreProvider);
//   try {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentReference userDoc =
//           firestore.collection(collectionName).doc(docId);
//       DocumentSnapshot document = await userDoc.get();

//       if (document.exists) {
//         Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//         print('データの取得に成功しました: $data');
//         return data;
//       } else {
//         print('ドキュメントが存在しません。');
//         return null;
//       }
//     } else {
//       print('ユーザーがログインしていません。');
//       return null;
//     }
//   } catch (error) {
//     print('データの取得中にエラーが発生しました: $error');
//     return null;
//   }
// }
