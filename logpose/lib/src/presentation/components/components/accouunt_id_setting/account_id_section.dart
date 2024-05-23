import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/domain/providers/text_field/account_id_field_provider.dart';

import '../../../../domain/providers/error_message/account_id_error_message_provider.dart';

import '../../common/red_error_message.dart';

import 'current_account_id_section/current_account_id_section.dart';
import 'new_account_id_section/new_account_id_section.dart';

class AccountIdSection extends ConsumerWidget {
  const AccountIdSection({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final accountIdController = ref.watch(accountIdFieldProvider(''));
    final accountIdErrorMessage = ref.watch(accountIdErrorMessageProvider);

    return Container(
      width: deviceWidth * 0.85,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: CurrentAccountIdSection(accountId: accountId),
          ),
          NewAccountIdSection(accountIdController: accountIdController),
          if (accountIdErrorMessage != null)
            RedErrorMessage(errorMessage: accountIdErrorMessage, fontSize: 14),
        ],
      ),
    );
  }
}
