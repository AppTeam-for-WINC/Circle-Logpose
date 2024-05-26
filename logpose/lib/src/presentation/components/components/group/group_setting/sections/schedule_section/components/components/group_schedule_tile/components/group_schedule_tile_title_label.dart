import 'package:flutter/cupertino.dart';

class GroupScheduleTileTitleLabel extends StatelessWidget {
  const GroupScheduleTileTitleLabel({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 69, 68, 68),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
