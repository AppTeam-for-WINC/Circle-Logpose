//Cupertinoデザインをインポート
import 'package:flutter/cupertino.dart';

//Firebaseをインポート
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Riverpodをインポート
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'amazon_app.dart';
void main() async {
  // Flutterアプリを初期化
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebaseを初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('HELLO WORLD');

  //Riverpodの適用範囲を設定
  const app = AmazonApp();
  const scope = ProviderScope(child: app);

  // アプリのウィジェットツリーを生成し、実行
  runApp(scope);
}
