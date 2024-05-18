import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../pages/user/password/password_setting_page.dart';

class PasswordSection extends ConsumerStatefulWidget {
  const PasswordSection({super.key});
  @override
  ConsumerState createState() => _PasswordSectionState();
}

class _PasswordSectionState extends ConsumerState<PasswordSection> {
  Future<void> _onPressed() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const PasswordSettingPage(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: deviceWidth * 0.88,
      height: deviceHeight * 0.06,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD9D9D9),
            offset: Offset(1, 3),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
        color: CupertinoColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _onPressed,
        child: const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    CupertinoIcons.lock_circle,
                    color: CupertinoColors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'パスワード',
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                CupertinoIcons.forward,
                color: CupertinoColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
