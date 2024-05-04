import 'package:flutter/cupertino.dart';

class RedErrorMessage extends StatelessWidget {
  const RedErrorMessage({
    super.key,
    required this.errorMessage,
    required this.fontSize,
  });
  final String errorMessage;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: TextStyle(
          color: CupertinoColors.systemRed,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
