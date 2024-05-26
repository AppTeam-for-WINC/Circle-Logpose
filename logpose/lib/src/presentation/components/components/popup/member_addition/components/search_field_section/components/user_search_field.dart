import 'package:flutter/cupertino.dart';

class UserSearchField extends StatelessWidget {
  const UserSearchField({super.key, required this.accountIdController});

  final TextEditingController accountIdController;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: accountIdController,
      prefix: const Icon(CupertinoIcons.search),
      style: const TextStyle(fontSize: 16),
      placeholder: 'ユーザIDの検索',
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 219, 251),
        borderRadius: BorderRadius.circular(80),
      ),
      autofocus: true,
    );
  }
}
