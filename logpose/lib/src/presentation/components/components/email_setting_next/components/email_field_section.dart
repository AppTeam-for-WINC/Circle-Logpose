import 'package:flutter/cupertino.dart';

import '../../../common/custom_text_field/custom_text_field.dart';
import '../../../common/custom_text_field/custom_text_field_label.dart';

class EmailFieldSection extends StatelessWidget {
  const EmailFieldSection({super.key, required this.newEmailController});

  final TextEditingController newEmailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const CustomTextFieldLabel(label: '新しいメールアドレス'),
          CustomTextField(textController: newEmailController),
        ],
      ),
    );
  }
}
