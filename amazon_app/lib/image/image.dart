import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

///デバイスの写真のアクセス権限がない場合に実行されるダイアログ。
Future<void> showPhotoAccessDeniedDialog(BuildContext context) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('写真アクセス許可が必要'),
      content: const Text('このアプリは写真へのアクセス許可が必要です。設定画面で写真へのアクセスを許可してください。'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Open device settings.'),
          onPressed: () async {
            // ユーザーをアプリの設定画面に誘導する
            await openAppSettings();
          },
        ),
        CupertinoDialogAction(
          child: const Text('cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

///デバイスの設定画面を開く。
Future<void> openAppSettings() async {
  final url = Uri.parse('app-settings:');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    debugPrint('設定画面を開けませんでした。');
  }
}
