import 'package:flutter/cupertino.dart';

class CustomTextFieldLabel extends StatelessWidget {
  const CustomTextFieldLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: deviceWidth * 0.8,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Color.fromARGB(255, 124, 122, 122),
          fontSize: 14,
        ),
      ),
    );
  }
}
