import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../popup/member_add_popup.dart';

class GroupSettingPage extends ConsumerWidget {
  const GroupSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          //タイトル
          middle: Text('Hello World'),
        ),
        child: Center(
          child: CupertinoButton(
              onPressed: () {
                showMemberAddPopup(context);
              },
              child: const Text('メンバー追加ポップアップ')),
        ),
      ),
    );
  }
}
