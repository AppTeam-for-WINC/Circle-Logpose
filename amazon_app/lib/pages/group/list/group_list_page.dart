import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//担当：　沖田昇太郎

class GroupListPage extends ConsumerWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          //タイトル
          middle: Text('Hello World'),
        ),
        child: Center(
          child: Text('iPhone15 pro 欲しいです。誰か買って下さい。連絡待ってます'),
        ),
      ),
    );
  }
}