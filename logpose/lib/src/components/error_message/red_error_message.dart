import 'package:flutter/cupertino.dart';

class RedErrorMessage extends StatelessWidget {
  const RedErrorMessage({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: CupertinoColors.systemRed,
          fontSize: 14,
        ),
      ),
    );
  }
}
