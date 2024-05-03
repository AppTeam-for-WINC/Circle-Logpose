import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/app_logo_and_title/app_logo_and_title.dart';
import '../../components/start/login_button.dart';
import '../../components/start/sign_up_button.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color.fromRGBO(80, 49, 238, 1),
              Color.fromRGBO(123, 97, 255, 1),
              Color.fromRGBO(123, 97, 255, 0.29),
            ],
            stops: [0, 0.2, 1],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppLogoAndTitle(),
            SizedBox(width: 300, height: 200),
            SignUpButton(),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}
