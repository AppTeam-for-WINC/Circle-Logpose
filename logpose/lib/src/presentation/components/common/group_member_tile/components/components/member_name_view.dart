import 'package:flutter/cupertino.dart';

import '../../../custom_text.dart';

class MemberNameView extends StatelessWidget {
  const MemberNameView({
    super.key,
    required this.name,
    required this.userNameTextSize,
  });

  final String name;
  final double userNameTextSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomText(
        text: name,
        textColor: CupertinoColors.black,
        fontSize: userNameTextSize,
      ),
    );
  }
}
