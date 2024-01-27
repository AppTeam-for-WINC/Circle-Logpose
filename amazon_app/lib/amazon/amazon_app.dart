import 'package:amazon_app/amazon/amazon_app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/group/create/group_create_page.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/popup/schedule_detail_confirm/schedule_detail_confirm.dart';
import '../pages/signup/signup_page.dart';
import '../pages/start/start_page.dart';
class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
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

      // パスを指定  例）　/home:　onPressed: () => Navigator.pushNamed(context, '/home'),　で押された際に指定されたパスに移動する。
      routes: {
        '/home': (context) => const HomePage(),
        '/start': (context) => const StartPage(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/group_create': (context) => const GroupCreatePage(),
        '/schedule_detail_confirm': (context) => const ScheduleDetailConfirm(),
      },
    );
  }
}