import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/error/password_error_message_provider.dart';
import '../../../../controllers/providers/user/account/password_provider.dart';
import '../user/user_setting_page.dart';

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

    final passwordErrorMessage = ref.watch(passwordErrorMessageProvider);
    final passwordSetting = ref.watch(passwordSettingProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) => const UserSettingPage(),
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
                    controller: passwordSetting.passwordController,
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
                    controller: passwordSetting.newPasswordController,
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

            // Error message.
            if (passwordErrorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  passwordErrorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),

            Container(
              width: 196,
              height: 58,
              margin: const EdgeInsets.only(top: 50),
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: const Color.fromARGB(255, 123, 97, 255),
                onPressed: () async {
                  final errorMessage = await passwordSetting.update();
                  if (errorMessage != null) {
                    ref.watch(passwordErrorMessageProvider.notifier).state =
                        errorMessage;
                    return;
                  }

                  if (!mounted) {
                    return;
                  }
                  await Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                      builder: (context) => const UserSettingPage(),
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
