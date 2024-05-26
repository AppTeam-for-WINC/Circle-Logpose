import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/red_error_message.dart';

import '../../components/components/navigation_bar/password_setting_navigation/password_setting_navigation_bar.dart';
import '../../components/components/password_setting/password_save_button.dart';
import '../../components/components/password_setting/password_setting_section.dart';

import '../../providers/error_message/password_error_message_provider.dart';

class PasswordSettingPage extends ConsumerStatefulWidget {
  const PasswordSettingPage({super.key});
  @override
  ConsumerState<PasswordSettingPage> createState() =>
      _PasswordSettingPageState();
}

class _PasswordSettingPageState extends ConsumerState<PasswordSettingPage> {
  @override
  Widget build(BuildContext context) {
    final passwordErrorMessage = ref.watch(passwordErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: const PasswordSettingNavigationBar(),
      child: Center(
        child: Column(
          children: [
            const PasswordSettingSection(),
            if (passwordErrorMessage != null)
              RedErrorMessage(errorMessage: passwordErrorMessage, fontSize: 16),
            const PasswordSaveButton(),
          ],
        ),
      ),
    );
  }
}
