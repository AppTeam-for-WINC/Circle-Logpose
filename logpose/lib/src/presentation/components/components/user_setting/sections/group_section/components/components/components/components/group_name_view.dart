import 'package:flutter/cupertino.dart';

import '../../../../../../../../common/custom_text.dart';

class GroupNameView extends StatelessWidget {
  const GroupNameView({
    super.key,
    required this.name,
    required this.groupNameTextSize,
  });

  final String name;
  final double groupNameTextSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomText(
        text: name,
        textColor: CupertinoColors.black,
        fontSize: groupNameTextSize,
      ),
    );
  }
}
