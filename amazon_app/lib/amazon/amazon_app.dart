import 'package:amazon_app/amazon/amazon_app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/src/group/create/group_create_page.dart';
import '../pages/src/home/home_page.dart';
import '../pages/src/login/login_page.dart';
import '../pages/src/signup/signup_page.dart';
import '../pages/src/start/start_page.dart';

class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      locale: const Locale('ja'),
      //homeを指定、とりあえずアプリを起動時、スタート画面を表示させる設定にしています。
      // home: const StartPage(),
      home: FutureBuilder<ConsumerWidget>(
        future: firstPage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CupertinoActivityIndicator();
          }
          return snapshot.data!;
        },
      ),

      // パスを指定
      routes: {
        '/home': (context) => const HomePage(),
        '/start': (context) => const StartPage(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/group_create': (context) => const GroupCreatePage(),
      },
    );
  }
}
