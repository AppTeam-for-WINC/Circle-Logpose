import 'package:flutter/cupertino.dart';

class CurrentEmail extends StatelessWidget {
  const CurrentEmail({super.key, required this.currentEmail});

  final String currentEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Text(
            currentEmail,
            style: const TextStyle(
              color: Color.fromARGB(255, 124, 122, 122),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
