import 'package:flutter/cupertino.dart';

class Username extends StatelessWidget {
  const Username({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: deviceWidth * 0.25),
        child: Text(
          name,
          style: const TextStyle(color: CupertinoColors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
