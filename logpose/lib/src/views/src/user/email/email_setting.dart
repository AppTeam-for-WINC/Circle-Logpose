import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/providers/user/account/email_provider.dart';

import '../user_setting_page.dart';

class EmailSettingPage extends ConsumerStatefulWidget {
  const EmailSettingPage({super.key});
  @override
  ConsumerState<EmailSettingPage> createState() => _EmailSettingPageState();
}

class _EmailSettingPageState extends ConsumerState<EmailSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final userEmail = ref.watch(userEmailProvider);
    final emailNotifier = ref.watch(userEmailProvider.notifier);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
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
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 243, 254),
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: deviceWidth * 0.8,
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: const Text(
                            '現在のメールアドレス',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 124, 122, 122),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 3,
                          ),
                          child: Row(
                            children: [
                              Text(
                                userEmail ?? '',
                                // emailController!.userEmail,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 124, 122, 122),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: deviceWidth * 0.8,
                    margin: const EdgeInsets.only(top: 30),
                    child: const Text(
                      '新しいメールアドレス',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 124, 122, 122),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: emailNotifier.emailController,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 243, 254),
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    autofocus: true,
                  ),
                ],
              ),
            ),
            Container(
              width: 196,
              height: 58,
              margin: const EdgeInsets.only(top: 100),
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: const Color.fromARGB(255, 123, 97, 255),
                onPressed: () async {
                  final success = await emailNotifier.changeEmail(
                    emailNotifier.emailController.text,
                  );
                  if (!success) {
                    return;
                  }
                  //Init
                  emailNotifier.emailController.clear();
                  if (!mounted) {
                    return;
                  }

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
                        color: Colors.white,
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
