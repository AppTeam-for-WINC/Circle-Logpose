import 'package:amazon_app/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazon_app/database/database.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // getSignUpData();
    // String primaryId = 'primary_id';
    // String foreignKey = 'foreign_key';
    // String username = userNameController.text;
    // String email = emailController.text;
    // String password = passwordController.text;

    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                Color.fromRGBO(116, 85, 255, 0.56),
                Color.fromRGBO(43, 0, 234, 0.18),
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //アイコン
              Container(
                margin: const EdgeInsets.all(23),
                child: const Column(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.calendar_today,
                      color: Colors.white,
                      size: 103,
                    ),

                    //文字
                    Text(
                      'Amazon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 346,
                margin: const EdgeInsets.all(13.5),
                child: const Text(
                  'メールアドレス登録',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),

              //mailaddres form
              SizedBox(
                width: 346,
                height: 46,
                child: CupertinoTextField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    color: Colors.transparent,
                    border: Border(
                        left: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        )),
                    //borderRadius: BorderRadius.all(30.0),
                  ),
                ),
              ),

              // Container(
              //   width: 346,
              //   margin: const EdgeInsets.all(13.5),
              //   child: const Text(
              //     'ユーザーネーム登録',
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),

              // //username form
              // SizedBox(
              //   width: 346,
              //   height: 46,
              //   child: CupertinoTextField(
              //     controller: userNameController,
              //     style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 20,
              //     ),
              //     decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(9),
              //         topRight: Radius.circular(9),
              //         bottomLeft: Radius.circular(9),
              //         bottomRight: Radius.circular(9),
              //       ),
              //       color: Colors.transparent,
              //       border: Border(
              //           left: BorderSide(
              //             color: Color.fromRGBO(123, 97, 255, 1),
              //             width: 1,
              //           ),
              //           top: BorderSide(
              //             color: Color.fromRGBO(123, 97, 255, 1),
              //             width: 1,
              //           ),
              //           right: BorderSide(
              //             color: Color.fromRGBO(123, 97, 255, 1),
              //             width: 1,
              //           ),
              //           bottom: BorderSide(
              //             color: Color.fromRGBO(123, 97, 255, 1),
              //             width: 1,
              //           )),
              //       //borderRadius: BorderRadius.all(30.0),
              //     ),
              //   ),
              // ),

              Container(
                width: 346,
                margin: const EdgeInsets.all(13.5),
                child: const Text(
                  'パスワード',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),

              //password form
              SizedBox(
                width: 346,
                height: 46,
                child: CupertinoTextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    color: Colors.transparent,
                    border: Border(
                        left: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Color.fromRGBO(123, 97, 255, 1),
                          width: 1,
                        )),
                  ),
                ),
              ),

              Container(
                height: 47,
                width: 195,
                margin: const EdgeInsets.all(23),
                child: CupertinoButton(
                    color: const Color.fromRGBO(80, 49, 238, 0.9),
                    borderRadius: BorderRadius.circular(30.0),
                    onPressed: () async {
                      // 以下でauthenticationにユーザ登録
                     bool a = await createAccount(emailController.text, passwordController.text);
                      // bool a = await updateSignUpData(
                      //     primaryId, foreignKey, username, email, password);
                      if (a) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {}
                    },
                    child: const Text('Sign up')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
