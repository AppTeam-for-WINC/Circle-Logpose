import 'package:flutter/cupertino.dart';

import '../../../../../../../navigations/pop_navigator.dart';

class GroupPickerModalCloseButton extends StatelessWidget {
  const GroupPickerModalCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      PopNavigator(context).pop();
    }

    return CupertinoButton(
      onPressed: onPressed,
      child: const Text('Close'),
    );
  }
}
