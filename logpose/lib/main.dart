//Firebaseをインポート
import 'package:firebase_core/firebase_core.dart';

//Cupertinoデザインをインポート
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Riverpodをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'firebase_options.dart';

// import 'test/test.dart';

void main() async {
  // Flutterアプリを初期化
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseを初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // const question = 'ichiroはイチローなのか';
  // await postChatGPT(question);

  //Riverpodの適用範囲を設定
  const app = LogposeApp();
  const scope = ProviderScope(child: app);

  // アプリのウィジェットツリーを生成し、実行
  runApp(scope);
}
