import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/usecase/group_schedule_use_case.dart';

import '../../../../models/database/user/user.dart';

class DeleteGroupScheduleButton extends ConsumerWidget {
  const DeleteGroupScheduleButton({
    super.key,
    required this.groupScheduleId,
    required this.groupMemberList,
  });
  final String groupScheduleId;
  final List<UserProfile?> groupMemberList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onPressed() async {
      final groupScheduleUseCase = ref.read(groupScheduleUseCaseProvider);
      await groupScheduleUseCase.deleteSchedule(
        groupMemberList,
        groupScheduleId,
      );
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
