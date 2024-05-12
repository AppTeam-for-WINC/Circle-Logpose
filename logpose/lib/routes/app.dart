import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../src/components/slide/slider/group_creation_and_list_tab_slider.dart';
import '../src/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../src/views/login/login_page.dart';
import '../src/views/signup/signup_page.dart';
import '../src/views/start/start_page.dart';
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
          pickerTextStyle: TextStyle(
            color: CupertinoColors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('ja')],
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
        '/home': (context) => const ScheduleListAndJoinedGroupTabSlider(),
        '/start': (context) => const StartPage(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/group_create': (context) => const GroupCreationAndListTabSlider(),
      },
    );
  }
}
