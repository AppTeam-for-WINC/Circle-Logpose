import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../../../../domain/entity/user_profile.dart';

import '../../../../../../../../../../../../handlers/group_schedule_delete_button_handler.dart';
import 'components/group_schedule_deletion_button.dart';

class GroupScheduleDeletionButton extends ConsumerWidget {
  const GroupScheduleDeletionButton({
    super.key,
    required this.groupMemberList,
    required this.groupScheduleId,
  });

  final List<UserProfile?> groupMemberList;
  final String groupScheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleToTap() async {
      final handler = GroupScheduleDeleteHandler(
        ref: ref,
        groupMemberList: groupMemberList,
        groupScheduleId: groupScheduleId,
      );

      await handler.handleDeleteSchedule();
    }

    return CupertinoButton(
      onPressed: handleToTap,
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
        child: GroupScheduleDeletionButtonIcon(),
      ),
    );
  }
}
