import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





// 下記updateData関数を使えばデータベースの更新ができます
void updateData() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('sign_up');
  DocumentReference userDoc = users.doc('primary_id'); // 更新したいドキュメントのID

  // 更新したいデータをマップとして定義
  Map<String, dynamic> updateData = {
    'user_name': 'a', // 更新したいフィールドと新しい値
    'mail_address': 'newemail@example.com',
  };

  userDoc.update(updateData).then((value) {
    print('データが正常に更新されました');
  }).catchError((error) {
    print('データの更新中にエラーが発生しました: $error');
  });
}

// 下記getData関数を使えばデータベースから取得できます。
void getData() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('sign_up');
  DocumentReference userDoc = users.doc('primary_id'); // 取得したいドキュメントのID

  userDoc.get().then((DocumentSnapshot document) {
    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // データを利用する（例: data['name']など）
      print('データの取得に成功しました: $data');
    } else {
      print('ドキュメントが存在しません。');
    }
  }).catchError((error) {
    print('データの取得中にエラーが発生しました: $error');
  });
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
              updateData();
              getData(); // データを更新する関数を呼び出す
            },
            child: Text('StartPage'),
          ),
        ),
      ),
    );
  }
}
