import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//担当：　ichiro

class StartPage extends ConsumerWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          //タイトル
          middle: Text('StartPage Title'),
        ),
        child: Center(
          child: Text('StartPage'),
        ),
      ),
    );
  }
}
