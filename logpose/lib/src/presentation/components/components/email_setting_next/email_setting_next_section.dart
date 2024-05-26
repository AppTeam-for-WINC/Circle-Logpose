import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifiers/user_email_notifier.dart';

import '../../../providers/text_field/email_field_provider.dart';

import 'components/current_email_field_section.dart';
import 'components/email_field_section.dart';

class EmailSettingNextSection extends ConsumerWidget {
  const EmailSettingNextSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final userEmailNotifier = ref.watch(userEmailNotifierProvider);
    final newEmailController = ref.watch(emailFieldProvider(''));

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          CurrentEmailFieldSection(currentEmail: userEmailNotifier),
          EmailFieldSection(newEmailController: newEmailController),
        ],
      ),
    );
  }
}
