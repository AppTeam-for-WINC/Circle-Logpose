import 'package:flutter/cupertino.dart';

import '../../../common/custom_text_field/custom_text_field_label.dart';

import 'components/current_account_id_button.dart';

class CurrentAccountIdSection extends StatelessWidget {
  const CurrentAccountIdSection({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextFieldLabel(label: '現在のアカウントID'),
        CurrentAccountIdButton(accountId: accountId),
      ],
    );
  }
}
