import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../navigations/to_user_setting_page_navigator.dart';
import '../../../common/slide_tab.dart';

class UserSettingTab extends ConsumerStatefulWidget {
  const UserSettingTab({super.key});

  @override
  ConsumerState createState() => UserSettingTabState();
}

class UserSettingTabState extends ConsumerState<UserSettingTab> {
  Future<void> _handleToTap() async {
    final navigator = ToUserSettingPageNavigator(context);
    await navigator.moveToPage();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTab(
      label: 'ユーザー設定',
      decorationColor: const Color.fromARGB(210, 239, 207, 255),
      textColor: const Color(0xFF7B61FF),
      icon: CupertinoIcons.settings,
      onTap: _handleToTap,
    );
  }
}
