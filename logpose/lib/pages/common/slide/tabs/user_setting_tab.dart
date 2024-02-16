import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/account/account_setting_page.dart';

class UserSettingTab extends ConsumerStatefulWidget {
  const UserSettingTab({super.key});

  @override
  ConsumerState createState() => UserSettingTabState();
}

class UserSettingTabState extends ConsumerState<UserSettingTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
          context,
          CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
            builder: (context) => const AccountSettingPage(),
          ),
          // (route) => route.settings.name == '/home',
        );
      },
      child: Container(
        width: 180,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: const Color.fromARGB(210, 239, 207, 255),
                borderRadius: BorderRadius.circular(33),
              ),
              child: const Center(
                child: Icon(
                  Icons.manage_accounts,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 5,
              ),
              child: const Text(
                'ユーザー設定',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF7B61FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
