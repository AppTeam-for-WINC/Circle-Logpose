import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/text_field/new_password_field_provider.dart';
import '../../../providers/text_field/password_field_provider.dart';

import '../../common/custom_text_field/custom_text_field.dart';
import '../../common/custom_text_field/custom_text_field_label.dart';

class PasswordSettingSection extends ConsumerWidget {
  const PasswordSettingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final passwordController = ref.watch(passwordFieldProvider(''));
    final newPasswordController = ref.watch(newPasswordFieldProvider);

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          const CustomTextFieldLabel(label: '現在のパスワード'),
          CustomTextField(
            textController: passwordController,
            obscure: true,
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              const CustomTextFieldLabel(label: '新しいパスワード'),
              CustomTextField(
                textController: newPasswordController,
                obscure: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
