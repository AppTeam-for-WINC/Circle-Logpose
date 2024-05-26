import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/presentation/components/components/slide/slider/group_creation_and_list_tab_slider.dart';
import '../src/presentation/components/components/slide/slider/schedule_list_and_joined_group_tab_slider.dart';
import '../src/presentation/pages/login/log_in_page.dart';
import '../src/presentation/pages/signup/sign_up_page.dart';
import '../src/presentation/pages/start/start_page.dart';
import 'app_controller.dart';

class LogposeApp extends ConsumerWidget {
  const LogposeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        future: firstPage(ref),
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
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LogInPage(),
        '/group_create': (context) => const GroupCreationAndListTabSlider(),
      },
    );
  }
}
