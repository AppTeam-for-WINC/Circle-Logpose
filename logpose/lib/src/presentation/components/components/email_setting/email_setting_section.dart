import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/text_field/password_field_provider.dart';

class EmailSettingSection extends ConsumerWidget {
  const EmailSettingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          SizedBox(
            width: deviceWidth * 0.8,
            child: const Text(
              'パスワードを入力して下さい',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 124, 122, 122),
                fontSize: 14,
              ),
            ),
          ),
          CupertinoTextField(
            controller: ref.watch(passwordFieldProvider('')),
            obscureText: true,
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
