import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/common/loading/loading_progress.dart';
import '../../widgets/progress/progress_indicator.dart';
import '../start/start_page.dart';
import 'login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LoginScreen();
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProgressProvider);
    final loadingErrorMessage = ref.watch(loadingErrorMessageProvider);
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: CupertinoButton(
          child: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) => const StartPage(),
              ),
            );
          },
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
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
                ],
              ),
            ),
            child: Stack(
              children: [
                const PageProgressIndicator(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'src/logpose/Logpose.png',
                            width: 100,
                            height: 100,
                          ),
                          const Text(
                            'Logpose',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Shippori_Mincho_B1',
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // Error message.
                    if (loadingErrorMessage != null)
                      Text(
                        loadingErrorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                
                    Container(
                      width: 346,
                      margin: const EdgeInsets.all(13.5),
                      child: const Text(
                        'メールアドレス',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
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
                            ),
                            top: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                            right: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                            bottom: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            ),
                            top: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                            right: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                            bottom: BorderSide(
                              color: Color.fromRGBO(123, 97, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 195,
                      margin: const EdgeInsets.all(23),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: const Color.fromRGBO(80, 49, 238, 0.9),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: isLoading
                            ? null
                            : () async {
                                final errorMessage = await loginController(
                                  context,
                                  ref,
                                  emailController,
                                  passwordController,
                                );
                
                                if (errorMessage != null) {
                                  LoadingProgressController
                                      .loadingErrorMessage(
                                    ref,
                                    errorMessage,
                                  );
                                }
                              },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Shippori_Mincho_B1',
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
