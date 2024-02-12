import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login/login_page.dart';
import '../signup/signup_page.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'src/logpost/Logpost.png',
              width: 100,
              height: 100,
            ),
            const Text(
              'Logpost',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Shippori_Mincho_B1',
              ),
            ),
            const SizedBox(
              width: 300,
              height: 200,
            ),
            SizedBox(
              width: 234,
              height: 60,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Shippori_Mincho_B1',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 234,
              height: 60,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromRGBO(80, 49, 238, 1),
                      fontSize: 18,
                      fontFamily: 'Shippori_Mincho_B1',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
