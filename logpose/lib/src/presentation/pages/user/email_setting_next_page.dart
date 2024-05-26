import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/common/red_error_message.dart';

import '../../components/components/email_setting_next/email_save_button.dart';
import '../../components/components/email_setting_next/email_setting_next_section.dart';
import '../../components/components/navigation_bar/email_setting_navigation/email_setting_navigation_bar.dart';

import '../../providers/error_message/email_error_message_provider.dart';

class EmailSettingNextPage extends ConsumerStatefulWidget {
  const EmailSettingNextPage({super.key, required this.password});
  final String password;

  @override
  ConsumerState<EmailSettingNextPage> createState() =>
      _EmailSettingNextPageState();
}

class _EmailSettingNextPageState extends ConsumerState<EmailSettingNextPage> {
  @override
  Widget build(BuildContext context) {
    final emailErrorMessage = ref.watch(emailErrorMessageProvider);
    
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: const EmailSettingNavigationBar(),
      child: Center(
        child: Column(
          children: [
            const EmailSettingNextSection(),
            if (emailErrorMessage != null)
              RedErrorMessage(errorMessage: emailErrorMessage, fontSize: 16),
            EmailSaveButton(password: widget.password),
          ],
        ),
      ),
    );
  }
}
