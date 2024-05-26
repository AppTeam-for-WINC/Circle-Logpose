import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../handlers/member_delete_handler.dart';

class MemberDeleteButton extends ConsumerWidget {
  const MemberDeleteButton({super.key, required this.accountId, this.groupId});
  final String accountId;
  final String? groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onPressed() async {
      final handler = MemberDeleteHandler(
        ref: ref,
        groupId: groupId,
        accountId: accountId,
      );
      await handler.handleToDeleteMember();
    }

    return CupertinoButton(
      onPressed: onPressed,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 231, 231, 231),
          borderRadius: BorderRadius.all(Radius.circular(999)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: Icon(CupertinoIcons.delete, color: CupertinoColors.black),
      ),
    );
  }
}
