import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/text_field/password_field_provider.dart';

import '../../common/custom_text_field/custom_text_field.dart';
import '../../common/custom_text_field/custom_text_field_label.dart';

class EmailSettingSection extends ConsumerWidget {
  const EmailSettingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final passwordController = ref.watch(passwordFieldProvider(''));

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          const CustomTextFieldLabel(label: 'パスワードを入力して下さい'),
          CustomTextField(textController: passwordController),
        ],
      ),
    );
  }
}
