import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/text_field/password_field_provider.dart';

class AuthPasswordField extends ConsumerWidget {
  const AuthPasswordField({super.key, this.password});
  final String? password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController passwordController;
    if (password == null) {
      passwordController = ref.watch(passwordFieldProvider(''));
    } else {
      passwordController = ref.watch(passwordFieldProvider(password));
    }

    return Column(
      children: [
        Container(
          width: 346,
          margin: const EdgeInsets.all(13.5),
          child: const Text(
            'パスワード',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: CupertinoColors.white,
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
              color: CupertinoColors.white,
              fontSize: 20,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              border: Border(
                left: BorderSide(color: Color.fromRGBO(123, 97, 255, 1)),
                top: BorderSide(color: Color.fromRGBO(123, 97, 255, 1)),
                right: BorderSide(color: Color.fromRGBO(123, 97, 255, 1)),
                bottom: BorderSide(color: Color.fromRGBO(123, 97, 255, 1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
