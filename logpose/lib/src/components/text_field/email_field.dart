import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/providers/auth/email_field_provider.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key, required this.label, this.email});
  final String label;
  final String? email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController;
    if (email == null) {
      emailController = ref.watch(emailFieldProvider(''));
    } else {
      emailController = ref.watch(emailFieldProvider(email!));
    }

    return Column(
      children: [
        Container(
          width: 346,
          margin: const EdgeInsets.all(13.5),
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          width: 346,
          height: 46,
          child: CupertinoTextField(
            controller: emailController,
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
