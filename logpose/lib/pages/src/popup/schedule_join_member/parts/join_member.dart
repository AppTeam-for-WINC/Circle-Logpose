import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../controller/common/time_controller.dart';
import '../../../../../database/user/user.dart';
import '../../schedule_detail_confirm/parts/reaponsed_member_controller.dart';

class JoinMember extends ConsumerStatefulWidget {
  const JoinMember({
    super.key,
    required this.scheduleId,
    required this.userProfile,
  });

  final String scheduleId;
  final UserProfile userProfile;

  @override
  ConsumerState<JoinMember> createState() => _JoinMemberState();
}

class _JoinMemberState extends ConsumerState<JoinMember> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final scheduleId = widget.scheduleId;
    final userProfile = widget.userProfile;

    final asyncMemberSchedule = ref.watch(
      watchGroupMemberScheduleProvider(
        (
          scheduleId: scheduleId,
          accountId: userProfile.accountId,
        ),
      ),
    );

    return SizedBox.expand(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(1, 1),
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 248, 233, 255),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 3),
          margin: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: userProfile.image.startsWith('http')
                              ? NetworkImage(userProfile.image)
                              : AssetImage(userProfile.image) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: deviceWidth * 0.25,
                      ),
                      child: Text(
                        userProfile.name,
                        style: const TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              asyncMemberSchedule.when(
                data: (memberSchedule) {
                  if (memberSchedule == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      if (memberSchedule.lateness || memberSchedule.leaveEarly)
                        Column(
                          children: [
                            if (memberSchedule.startAt != null)
                              Text(
                                formatDateTimeExcYear(memberSchedule.startAt!),
                                style: const TextStyle(fontSize: 13),
                              ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                            ),
                            if (memberSchedule.endAt != null)
                              Text(
                                formatDateTimeExcYear(memberSchedule.endAt!),
                                style: const TextStyle(fontSize: 13),
                              ),
                          ],
                        ),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => Text('$error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
