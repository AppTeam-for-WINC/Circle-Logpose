import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/controllers/providers/text_field/account_id_field_provider.dart';

import '../../../../../components/error_message/red_error_message.dart';
import '../../../../../controllers/providers/error/account_id_error_message_provider.dart';
import '../../../../../controllers/providers/user/set_user_profile_provider.dart';

class AccountIdSection extends ConsumerWidget {
  const AccountIdSection({super.key, required this.accountId});
  final String accountId;

  void _copyToClipboard(String accountId) {
    _copyToClipboard(accountId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final accountIdErrorMessage = ref.watch(accountIdErrorMessageProvider);

    final userProfile = ref.watch(setUserProfileDataProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: deviceWidth * 0.8,
      margin: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromARGB(255, 124, 122, 122)),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: deviceWidth * 0.8,
                  child: const Text(
                    '現在のアカウントID',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 122, 122),
                      fontSize: 14,
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () => _copyToClipboard(userProfile.accountId),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: deviceWidth * 0.8),
                        child: Text(
                          userProfile.accountId,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 124, 122, 122),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: deviceWidth * 0.8,
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              '新しいアカウントID',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 124, 122, 122),
                fontSize: 14,
              ),
            ),
          ),
          CupertinoTextField(
            controller: ref.watch(accountIdFieldProvider(accountId)),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 243, 254),
              border: Border(bottom: BorderSide()),
            ),
            autofocus: true,
          ),
          if (accountIdErrorMessage != null)
            RedErrorMessage(errorMessage: accountIdErrorMessage, fontSize: 14),
        ],
      ),
    );
  }
}
