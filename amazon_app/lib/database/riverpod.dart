import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);


// ref.read()
// ref.watch()

// int alpha = FirebaseFirestore(
//     x = 10;
// );
// alpha = 20;

//https://qiita.com/taisei_dev/items/4c9d9572a56051a1d51f



//他にやらなければいけないことは、
//(backend)
//・メールアドレス、パスワードの変更がauth側で行われていない。
//・imagepickerと連携していない。
//・グループのadmin, membershipメンバーの追加などを行っていない。ユーザー側も然り。

//(frontend)
//・segmentTabを一刻も早く改良しなければならない。
//・アカウント設定画面に移動できない。
//・画面の描画設定がうまくいっていない。
//・グループの新規作成機能を着手したい。
