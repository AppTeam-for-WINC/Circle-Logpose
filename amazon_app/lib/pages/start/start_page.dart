import 'package:amazon_app/pages/login/login_page.dart';
import 'package:amazon_app/pages/signup/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//担当：　ichiro

class StartPage extends ConsumerWidget {
  const StartPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Container(
          color: Color.fromRGBO(80, 49, 238, 0.9),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //アイコン
              Icon(
                CupertinoIcons.calendar_today,
                color: Colors.white,
                size: 103,
              ),

              //文字
              const Text(
                'AMAZON',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontStyle: FontStyle.normal,
                ),
              ),

              //余白用
              const SizedBox(
                width: 300,
                height: 200,
              ),

              //サインアップボタン
              SizedBox(
                width: 234,
                height: 60,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              //ログインボタン
              SizedBox(
                width: 234,
                height: 60,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      "login",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(80, 49, 238, 0.9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
