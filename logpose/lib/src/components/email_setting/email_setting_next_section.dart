import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/text_field/email_field_provider.dart';
import '../../domain/providers/user/account/email_provider.dart';
import '../../domain/providers/user/set_user_profile_provider.dart';

class EmailSettingNextSection extends ConsumerWidget {
  const EmailSettingNextSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final userEmail = ref.watch(userEmailProvider);
    if (userEmail == null) {
      return const SizedBox.shrink();
    }

    final userProfile = ref.watch(setUserProfileDataProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 243, 254),
              border: Border(bottom: BorderSide()),
            ),
            child: Column(
              children: [
                Container(
                  width: deviceWidth * 0.8,
                  padding: const EdgeInsets.only(bottom: 8),
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
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Text(
                        userEmail,
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
            controller: ref.watch(emailFieldProvider('')),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 243, 254),
              border: Border(bottom: BorderSide()),
            ),
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
