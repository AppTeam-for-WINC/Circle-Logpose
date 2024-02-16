import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../pages/src/group/create/group_create_page.dart';
import '../pages/src/home/home_page.dart';
import '../pages/src/login/login_page.dart';
import '../pages/src/signup/signup_page.dart';
import '../pages/src/start/start_page.dart';
import 'app_controller.dart';

class LogposeApp extends StatelessWidget {
  const LogposeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.white,
          textStyle: TextStyle(color: CupertinoColors.black),
          dateTimePickerTextStyle: TextStyle(color: CupertinoColors.black),
          pickerTextStyle: TextStyle(color: CupertinoColors.black,),
        ),
      ),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('ja'),
      ],
      locale: const Locale('ja'),
      home: FutureBuilder(
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
