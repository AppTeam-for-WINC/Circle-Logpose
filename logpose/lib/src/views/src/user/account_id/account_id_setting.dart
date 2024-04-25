import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controllers/controllers/user/update_account_id.dart';
import '../../../../controllers/providers/error/account_id_error_message_provider.dart';
import '../../../../controllers/providers/user/set_user_profile_provider.dart';

import '../../../../utils/clipboard/copy_to_clipboard.dart';

import '../user_setting_page.dart';

class AccountIdSettingPage extends ConsumerStatefulWidget {
  const AccountIdSettingPage({super.key});
  @override
  ConsumerState<AccountIdSettingPage> createState() =>
      AccountIdSettingPageState();
}

class AccountIdSettingPageState extends ConsumerState<AccountIdSettingPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final accountIdErrorMessage = ref.watch(accountIdErrorMessageProvider);
    final userProfile = ref.watch(setUserProfileDataProvider);
    final userProfileNotifier = ref.watch(setUserProfileDataProvider.notifier);
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          onPressed: () async {
            //Init
            userProfileNotifier.accountIdController.clear();

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
                        SizedBox(
                          width: deviceWidth * 0.8,
                          child: const Text(
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
                            final userRef =
                                await userProfileNotifier.initUserProfile();
                            copyToClipboard(userRef.accountId);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: deviceWidth * 0.8,
                                ),
                                child: Text(
                                  userProfile!.accountId,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 124, 122, 122),
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                      '新しいアカウントID',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 124, 122, 122),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: userProfileNotifier.accountIdController,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 243, 254),
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    autofocus: true,
                  ),

                  // Error message.
                  if (accountIdErrorMessage != null)
                    Center(
                      child: Text(
                        accountIdErrorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
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
                  final errorMessage = await UpdateAccountId.update(
                    userProfileNotifier.accountIdController.text,
                  );
                  if (errorMessage != null) {
                    ref.watch(accountIdErrorMessageProvider.notifier).state =
                        errorMessage;
                    return;
                  }

                  //Init
                  userProfileNotifier.setNewAccountId(
                    userProfileNotifier.accountIdController.text,
                  );
                  //Init
                  userProfileNotifier.accountIdController.clear();

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
    );
  }
}
