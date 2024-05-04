import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/email_setting/email_setting_section.dart';
import '../../../components/email_setting/save_button.dart';
import '../../../components/navigation_bar/email_setting_navigation_bar.dart';

class EmailSettingPage extends ConsumerStatefulWidget {
  const EmailSettingPage({super.key});
  @override
  ConsumerState<EmailSettingPage> createState() => _EmailSettingPageState();
}

class _EmailSettingPageState extends ConsumerState<EmailSettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: EmailSettingNavigationBar(context: context, ref: ref),
      child: const Center(
        child: Column(
          children: [
            EmailSettingSection(),
            SaveButton(),
          ],
        ),
      ),
    );
  }
}
