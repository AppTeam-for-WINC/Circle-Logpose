import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//logindata update
//logindata
//create Sign up

// 下記updateLoginData関数を使えばデータベースの更新ができます
Future<bool> updateLoginData(String primaryKey, String foreignKey,
    String userName, String mailAddress, String password) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('login');
    DocumentReference userDoc = users.doc(primaryKey);

    Map<String, dynamic> updateData = {
      'user_name': userName,
      'mail_address': mailAddress,
      'password': password,
      'foreign_key': foreignKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true;
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false;
  }
}

// 下記getLogInData関数を使えばデータベースから取得できます。
Future<bool> getLoginData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('login');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

// 下記updateSignUpData関数を使えばデータベースの更新ができます
Future<bool> updateSignUpData(String primaryId, String foreignKey,
    String userName, String mailAddress, String password) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('sign_up');
    DocumentReference userDoc = users.doc(primaryId);

    Map<String, dynamic> updateData = {
      'user_name': userName,
      'mail_address': mailAddress,
      'password': password,
      'foreign_key': foreignKey,
    };

    await userDoc.update(updateData);
    print('データのアップデート成功しました');
    return true; // Data updated successfully
  } catch (error) {
    print('データのアップデート中にエラーが発生しました: $error');
    return false; // Error occurred during data update
  }
}

// 下記getSignUpData関数を使えばデータベースから取得できます。
Future<bool> getSignUpData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('sign_up');
    DocumentReference userDoc = users.doc('primary_id');

    DocumentSnapshot document = await userDoc.get();

    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      print('データの取得に成功しました: $data');
      return true;
    } else {
      print('ドキュメントが存在しません。');
      return false;
    }
  } catch (error) {
    print('データの取得中にエラーが発生しました: $error');
    return false;
  }
}

class DatabasePage extends ConsumerWidget {
  const DatabasePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          //タイトル
          middle: Text('StartPage Title'),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              updateSignUpData('primary_id', '', 'test', 'test', 'test');
              getSignUpData(); // データを更新する関数を呼び出す
              updateLoginData('primary_id', '', 'test', 'test', 'test');
              getLoginData(); // データを更新する関数を呼び出す
            },
            child: Text('StartPage'),
          ),
        ),
      ),
    );
  }
}
