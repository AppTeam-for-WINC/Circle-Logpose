import 'package:flutter/cupertino.dart';

import '../../../../common/custom_text_field/custom_text_field_label.dart';
import 'components/current_email.dart';

class CurrentEmailFieldSection extends StatelessWidget {
  const CurrentEmailFieldSection({super.key, required this.currentEmail});

  final String currentEmail;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 243, 254),
        border: Border(bottom: BorderSide()),
      ),
      child: Column(
        children: [
          const CustomTextFieldLabel(label: '現在のメールアドレス'),
          CurrentEmail(currentEmail: currentEmail),
        ],
      ),
    );
  }
}
