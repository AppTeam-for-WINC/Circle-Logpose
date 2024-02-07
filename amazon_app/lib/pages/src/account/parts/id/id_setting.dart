import 'package:amazon_app/pages/src/account/account_setting_page.dart';
import 'package:amazon_app/pages/src/account/account_setting_controller.dart';
import 'package:amazon_app/pages/src/account/parts/id/id_setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdSettingPage extends ConsumerStatefulWidget {
  const IdSettingPage({super.key});
  @override
  ConsumerState<IdSettingPage> createState() => IdSettingPageState();
}

class IdSettingPageState extends ConsumerState<IdSettingPage> {
  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  @override
  Widget build(BuildContext context) {
    final accountId = ref.watch(userProfileProvider);
    final accountIdNotifier = ref.watch(userProfileProvider.notifier);
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: CupertinoNavigationBar(
        leading: TextButton.icon(
          onPressed: () async {
            //Init
            accountIdNotifier.accountIdController.clear();

            await Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                builder: (context) => const AccountSettingPage(),
              ),
              (_) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          label: const Text(
            '戻る',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 243, 254),
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 336,
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 124, 122, 122),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 346,
                            child: Text(
                              '現在のアカウントID',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 124, 122, 122),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final userRef = await readUserRef();
                              copyToClipboard(userRef.accountId);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  accountId!.accountId,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 124, 122, 122),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 346,
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        '新しいアカウントID',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 124, 122, 122),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    CupertinoTextField(
                      controller: accountIdNotifier.accountIdController,
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
                margin: const EdgeInsets.only(top: 100),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  backgroundColor: const Color.fromARGB(255, 123, 97, 255),
                  onPressed: () async {
                    final success = await changeAccountId(
                      accountIdNotifier.accountIdController.text,
                    );
                    if (!success) {
                      return;
                    }
                    //Init
                    accountIdNotifier.changeAccountId(
                      accountIdNotifier.accountIdController.text,
                    );
                    //Init
                    accountIdNotifier.accountIdController.clear();

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
      ),
    );
  }
}
