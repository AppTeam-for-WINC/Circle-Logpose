import 'package:flutter/cupertino.dart';

class UserName extends StatelessWidget {
  const UserName({super.key, required this.username});
  final String username;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: 120,
        ),
        child: Text(
          username,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
