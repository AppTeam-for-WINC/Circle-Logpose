import 'package:flutter/cupertino.dart';

import '../../../../../../../../../../common/custom_text.dart';

class GroupScheduleTileTitleLabel extends StatelessWidget {
  const GroupScheduleTileTitleLabel({
    super.key,
    required this.title,
    required this.titleTextSize,
  });

  final String title;
  final double titleTextSize;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
          child: CustomText(
            text: title,
            textColor: const Color.fromARGB(255, 69, 68, 68),
            fontSize: titleTextSize,
          ),
        ),
      ],
    );
  }
}
