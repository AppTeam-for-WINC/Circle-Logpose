import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_member_schedule_facade.dart';

final memberScheduleUpdaterControllerProvider =
    Provider<MemberScheduleUpdaterController>(
  MemberScheduleUpdaterController.new,
);

class MemberScheduleUpdaterController {
  MemberScheduleUpdaterController(this.ref);
  final Ref ref;

  Future<void> updateStartAt(String memberScheduleId, DateTime? startAt) async {
    final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
    await memberScheduleFacade.updateStartAt(memberScheduleId, startAt);
  }

  Future<void> updateEndAt(String memberScheduleId, DateTime? endAt) async {
    final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
    await memberScheduleFacade.updateEndAt(memberScheduleId, endAt);
  }
}
