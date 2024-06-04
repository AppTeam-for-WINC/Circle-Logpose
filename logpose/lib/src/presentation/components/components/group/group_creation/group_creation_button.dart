import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/group_creation_save_button_handler.dart';

class GroupCreationButton extends ConsumerStatefulWidget {
  const GroupCreationButton({super.key});
  @override
  ConsumerState createState() => _GroupCreationButtonState();
}

class _GroupCreationButtonState extends ConsumerState<GroupCreationButton> {
  Future<void> handleToCreate() async {
    final handler = GroupCreationSaveButtonHandler(context, ref);
    await handler.handleToCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color(0xFF7B61FF),
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
        onPressed: handleToCreate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: CupertinoColors.white,
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.add,
                  size: 25,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Text('団体を作成', style: TextStyle(color: CupertinoColors.white)),
          ],
        ),
      ),
    );
  }
}
