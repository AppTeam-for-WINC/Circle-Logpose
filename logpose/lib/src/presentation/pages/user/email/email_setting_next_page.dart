import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/providers/error_message/email_error_message_provider.dart';

import '../../../components/common/red_error_message.dart';
import '../../../components/components/email_setting/email_setting_next_section.dart';
import '../../../components/components/email_setting/save_button.dart';
import '../../../components/components/navigation_bar/email_setting_navigation_bar.dart';

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
      navigationBar: EmailSettingNavigationBar(context: context, ref: ref),
      child: Center(
        child: Column(
          children: [
            const EmailSettingNextSection(),
            if (emailErrorMessage != null)
              RedErrorMessage(errorMessage: emailErrorMessage, fontSize: 16),
            SaveButton(password: widget.password),
          ],
        ),
      ),
    );
  }
}
