import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: textController,
      obscureText: true,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 243, 254),
        border: Border(bottom: BorderSide()),
      ),
      autofocus: true,
    );
  }
}
