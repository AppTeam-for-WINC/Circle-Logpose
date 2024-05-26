import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifiers/user_profile_notifier.dart';

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

    final userProfile = ref.watch(userProfileNotifierProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          const CustomTextFieldLabel(label: '現在のパスワード'),
          CustomTextField(textController: passwordController),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                const CustomTextFieldLabel(label: '新しいパスワード'),
                CustomTextField(textController: newPasswordController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
