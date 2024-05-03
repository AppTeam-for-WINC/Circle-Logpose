import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/accouunt_id_setting/account_id_section.dart';
import '../../../components/accouunt_id_setting/save_button.dart';
import '../../../components/navigation_bar/account_id_setting_navigation_bar.dart';
import '../../../controllers/providers/user/set_user_profile_provider.dart';

class AccountIdSettingPage extends ConsumerStatefulWidget {
  const AccountIdSettingPage({super.key});
  @override
  ConsumerState<AccountIdSettingPage> createState() =>
      AccountIdSettingPageState();
}

class AccountIdSettingPageState extends ConsumerState<AccountIdSettingPage> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(setUserProfileDataProvider);
    if (userProfile == null) {
      return const SizedBox.shrink();
    }
    
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 254),
      navigationBar: AccountIdSettingNavigationBar(context: context, ref: ref),
      child: Center(
        child: Column(
          children: [
            AccountIdSection(accountId: userProfile.accountId),
            const SaveButton(),
          ],
        ),
      ),
    );
  }
}
