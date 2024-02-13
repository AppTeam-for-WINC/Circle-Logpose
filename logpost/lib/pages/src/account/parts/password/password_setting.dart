import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account_setting_page.dart';
import 'password_setting_controller.dart';

class PasswordSettingPage extends ConsumerStatefulWidget {
  const PasswordSettingPage({super.key});
  @override
  ConsumerState<PasswordSettingPage> createState() =>
      _PasswordSettingPageState();
}

class _PasswordSettingPageState extends ConsumerState<PasswordSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final passwordNotifier = ref.watch(passwordSettingProvider.notifier);
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
            // Init
            passwordNotifier.passwordController.clear();
            passwordNotifier.newPasswordController.clear();

            await Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) => const AccountSettingPage(),
              ),
              (_) => false,
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 243, 254),
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: deviceWidth * 0.8,
              margin: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: deviceWidth * 0.8,
                    child: const Text(
                      '現在のパスワード',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 124, 122, 122),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: passwordNotifier.passwordController,
                    obscureText: true,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 243, 254),
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    autofocus: true,
                  ),
                  Container(
                    width: deviceWidth * 0.8,
                    margin: const EdgeInsets.only(top: 30),
                    child: const Text(
                      '新しいパスワード',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 124, 122, 122),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: passwordNotifier.newPasswordController,
                    obscureText: true,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 243, 254),
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 196,
              height: 58,
              margin: const EdgeInsets.only(top: 60),
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: const Color.fromARGB(255, 123, 97, 255),
                onPressed: () async {
                  final success = await UserPasswordSetting().update(
                    passwordNotifier.passwordController.text,
                    passwordNotifier.newPasswordController.text,
                  );
                  if (!success) {
                    return;
                  }
                  if (!mounted) {
                    return;
                  }

                  // Init
                  passwordNotifier.passwordController.clear();
                  passwordNotifier.newPasswordController.clear();

                  await Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                      builder: (context) => const AccountSettingPage(),
                    ),
                    (_) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                    const Text(
                      '変更を保存',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
