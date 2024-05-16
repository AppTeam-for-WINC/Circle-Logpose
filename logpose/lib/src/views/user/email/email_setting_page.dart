import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/red_error_message.dart';
import '../../../components/email_setting/email_setting_section.dart';
import '../../../components/email_setting/move_to_page_button.dart';
import '../../../components/navigation_bar/email_setting_navigation_bar.dart';
import '../../../domain/providers/error/password_error_message_provider.dart';

class EmailSettingPage extends ConsumerStatefulWidget {
  const EmailSettingPage({super.key});
  @override
  ConsumerState<EmailSettingPage> createState() => _EmailSettingPageState();
}

class _EmailSettingPageState extends ConsumerState<EmailSettingPage> {
  @override
  Widget build(BuildContext context) {
    final passwordErrorMessage = ref.watch(passwordErrorMessageProvider);

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: EmailSettingNavigationBar(context: context, ref: ref),
      child: Center(
        child: Column(
          children: [
            const EmailSettingSection(),
            if (passwordErrorMessage != null)
              RedErrorMessage(errorMessage: passwordErrorMessage, fontSize: 16),
            const MoveToNextPageButton(),
          ],
        ),
      ),
    );
  }
}
