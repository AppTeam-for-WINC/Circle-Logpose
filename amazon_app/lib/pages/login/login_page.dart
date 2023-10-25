// ignore_for_file: empty_constructor_bodies

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

//担当：　ichiro

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _email = '';
    String _password = '';

    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          //タイトル
          middle: Text('Login Page'),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'mailaddress'),
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'password'),
                  obscureText: true,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'confirm password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final User? user = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password))
                          .user;
                      if (user != null)
                        print("ログインしました　${user.email} , ${user.uid}");
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
