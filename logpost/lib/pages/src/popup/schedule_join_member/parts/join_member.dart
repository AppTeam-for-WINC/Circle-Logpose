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
    final asyncMemberSchedule =
        ref.watch(watchGroupMemberScheduleProvider(scheduleId));

    return Container(
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
                    width: 40,
                    height: 40,
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
                      maxWidth: deviceWidth * 0.2,
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
            // Bag
            asyncMemberSchedule.when(
              data: (memberScheduleList) {
                if (memberScheduleList.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: [
                    ...memberScheduleList.map((memberSchedule) {
                      if (memberSchedule == null) {
                        return const SizedBox.shrink();
                      }
                      if (memberSchedule.lateness ||
                          memberSchedule.leaveEarly) {
                        return Column(
                          children: [
                            Text(
                              formatDateTimeExcYear(memberSchedule.startAt!),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 2,
                              ),
                              child: Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Text(formatDateTimeExcYear(memberSchedule.endAt!)),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => Text('$error'),
            ),
          ],
        ),
      ),
    );
  }
}
