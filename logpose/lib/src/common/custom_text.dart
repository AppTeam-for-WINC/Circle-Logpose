import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: CupertinoColors.black),
      ),
    );
  }
}
