import 'package:flutter/cupertino.dart';

import '../../../common/custom_text_field/custom_text_field.dart';
import '../../../common/custom_text_field/custom_text_field_label.dart';


class NewAccountIdSection extends StatelessWidget {
  const NewAccountIdSection({super.key, required this.accountIdController});

  final TextEditingController accountIdController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextFieldLabel(label: '新しいアカウントID'),
        CustomTextField(textController: accountIdController),
      ],
    );
  }
}
