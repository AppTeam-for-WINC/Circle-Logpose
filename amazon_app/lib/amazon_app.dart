import 'package:amazon_app/pages/popup/account_setting_popup.dart';
import 'package:flutter/cupertino.dart';
import 'pages/group/create/group_create_page.dart';
import 'pages/group/setting/group_setting_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/popup/schedule_detail_confirm/schedule_detail_confirm.dart';
import 'pages/signup/signup_page.dart';
import 'pages/start/start_page.dart';
class AmazonApp extends StatelessWidget {
  const AmazonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      //ホームを指定、とりあえずアプリを起動時、スタート画面を表示させる設定にしています。
      home: const StartPage(),

      // パスを指定  例）　/home:　onPressed: () => Navigator.pushNamed(context, '/home'),　で押された際に指定されたパスに移動する。
      routes: {
        '/home': (context) => const HomePage(),
        '/start': (context) => const StartPage(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/group_create': (context) => const GroupCreatePage(),
        '/group_setting': (context) => const GroupSettingPage(),
        '/schedule_detail_confirm': (context) => const ScheduleDetailConfirm(),
      },
    );
  }
}