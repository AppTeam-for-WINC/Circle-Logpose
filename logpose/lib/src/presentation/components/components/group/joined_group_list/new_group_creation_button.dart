import 'package:flutter/cupertino.dart';

import '../../../../navigations/new_group_creation_button_navigator.dart';

class NewGroupCreationButton extends StatelessWidget {
  const NewGroupCreationButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleToTap() async {
      final navigator = NewGroupCreationButtonNavigator(context);
      await navigator.moveToPage();
    }

    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color.fromARGB(255, 107, 88, 252),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(225, 127, 145, 145),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: handleToTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: CupertinoColors.white,
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.add,
                  size: 20,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                '新しい団体を作成',
                style: TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
