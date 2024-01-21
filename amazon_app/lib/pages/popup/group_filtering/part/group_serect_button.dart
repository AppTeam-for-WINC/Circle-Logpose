import 'package:amazon_app/pages/popup/group_filtering/group_filtering_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupSerectButton extends ConsumerState<GroupFilteringPopup> {
  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    return Container(
      width: deviceW * 0.81,
      height: 92,
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45),
      ),
      child: CupertinoButton(
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(
                left: 10,
                right: 30,
                bottom: 10,
              ),
              child: const Icon(
                Icons.account_circle,
                color: Color.fromRGBO(80, 49, 238, 1),
                size: 65,
              ),
            ),
            const Text(
              '仮団体6',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            )
          ],
        ),
        onPressed: () {
          //ここに処理が入るよ！！
        },
      ),
    );
  }
}
