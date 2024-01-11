import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordSettingPage extends ConsumerWidget {
  const PasswordSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CupertinoPageScaffold(
      child: Text('Change Password')
    );
  }
}
