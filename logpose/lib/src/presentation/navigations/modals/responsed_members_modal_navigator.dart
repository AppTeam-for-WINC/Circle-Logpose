import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entity/group_profile.dart';
import '../../../domain/entity/group_schedule.dart';
import '../../../domain/entity/user_profile.dart';
import '../../../domain/providers/group/members/listen_group_member_profile_not_absence_list_provider.dart';

import '../../components/components/popup/schedule_join_member/join_schedule_view.dart';

class ResponsedMemebersModalNavigator {
  ResponsedMemebersModalNavigator(this.context, this.ref);

  final BuildContext context;
  final WidgetRef ref;

  Future<void> showModal({
    required String scheduleId,
    required GroupProfile groupProfile,
    required GroupSchedule groupSchedule,
  }) async {
    final asyncGroupMember =
        ref.watch(listenGroupMemberProfileNotAbsenceListProvider(scheduleId));
    await showCupertinoModalPopup<JoinScheduleView>(
      context: context,
      builder: (BuildContext context) {
        return asyncGroupMember.when(
          data: (membershipProfileList) {
            return _buildScheduleJoinMember(
              groupProfile: groupProfile,
              memberProfiles: membershipProfileList,
              scheduleId: scheduleId,
              groupSchedule: groupSchedule,
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Text('$error'),
        );
      },
    );
  }

  Widget _buildScheduleJoinMember({
    required String scheduleId,
    required GroupProfile groupProfile,
    required GroupSchedule groupSchedule,
    required List<UserProfile?> memberProfiles,
  }) {
    return JoinScheduleView(
      groupProfile: groupProfile,
      memberProfiles: memberProfiles,
      scheduleId: scheduleId,
      groupSchedule: groupSchedule,
    );
  }
}