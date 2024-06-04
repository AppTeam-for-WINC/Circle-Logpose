import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../src/presentation/navigations/pop_navigator.dart';

class DeviceManager {
  const DeviceManager();

  /// デバイスの写真のアクセス権限がない場合に実行されるダイアログ。
  Future<void> showPhotoAccessDeniedDialog(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('写真アクセス許可が必要'),
        content: const Text('このアプリは写真へのアクセス許可が必要です。設定画面で写真へのアクセスを許可してください。'),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: openAppSettings,
            child: const Text('Open device settings.'),
          ),
          CupertinoDialogAction(
            onPressed: () => PopNavigator(context).pop(),
            child: const Text('cancel'),
          ),
        ],
      ),
    );
  }

  /// デバイスの設定画面を開く。
  Future<void> openAppSettings() async {
    final url = Uri.parse('app-settings:');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('設定画面を開けませんでした。');
    }
  }
}
