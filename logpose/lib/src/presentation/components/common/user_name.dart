import 'package:flutter/cupertino.dart';

class Username extends StatelessWidget {
  const Username({super.key, required this.name, required this.textSize});

  final String name;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: deviceWidth * 0.25),
        child: Text(
          name,
          style: TextStyle(color: CupertinoColors.black, fontSize: textSize),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
