import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/text_field/new_password_field_provider.dart';
import '../../../../domain/providers/text_field/password_field_provider.dart';
import '../../../notifiers/user_profile_notifier.dart';

class PasswordSettingSection extends ConsumerWidget {
  const PasswordSettingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final userProfile = ref.watch(userProfileNotifierProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return Container(
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
            controller:  ref.watch(passwordFieldProvider('')),
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
            controller: ref.watch(newPasswordFieldProvider),
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
    );
  }
}
