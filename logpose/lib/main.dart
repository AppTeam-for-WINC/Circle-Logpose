import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'routes/app.dart';
// import 'test/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // To-do activate ChatGPT.
  // const question = 'ichiroはイチローなのか';
  // await postChatGPT(question);

  const app = LogposeApp();
  const scope = ProviderScope(child: app);

  runApp(scope);
}
