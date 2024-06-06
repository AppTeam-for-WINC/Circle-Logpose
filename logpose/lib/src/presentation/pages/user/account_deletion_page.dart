import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/red_error_message.dart';

import '../../components/components/account_deletion/account_deletion_button.dart';
import '../../components/components/account_deletion/acount_deletion_section.dart';
import '../../components/components/navigation_bar/password_setting_navigation/password_setting_navigation_bar.dart';

import '../../providers/error_message/password_error_message_provider.dart';

class AccountDeletionPage extends ConsumerStatefulWidget {
  const AccountDeletionPage({super.key});
  @override
  ConsumerState<AccountDeletionPage> createState() =>
      _AccountDeletionPageState();
}

class _AccountDeletionPageState extends ConsumerState<AccountDeletionPage> {
  @override
  Widget build(BuildContext context) {
    final passwordErrorMessage = ref.watch(passwordErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: const PasswordSettingNavigationBar(),
      child: Center(
        child: Column(
          children: [
            const AccountDeletionSection(),
            if (passwordErrorMessage != null)
              RedErrorMessage(errorMessage: passwordErrorMessage, fontSize: 16),
            const AccountDeletionButton(),
          ],
        ),
      ),
    );
  }
}
