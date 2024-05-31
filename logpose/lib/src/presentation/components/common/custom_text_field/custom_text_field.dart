import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.obscure,
  });

  final TextEditingController textController;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: textController,
      obscureText: obscure,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 243, 254),
        border: Border(bottom: BorderSide()),
      ),
      autofocus: true,
    );
  }
}
