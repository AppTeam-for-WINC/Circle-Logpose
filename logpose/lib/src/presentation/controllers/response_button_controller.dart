import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/group_member_schedule_facade.dart';

import '../../domain/model/schedule_response_params_model.dart';

final responseButtonControllerProvider =
    Provider<ResponseButtonController>(ResponseButtonController.new);

class ResponseButtonController {
  ResponseButtonController(this.ref);
  final Ref ref;

  Future<void> updateResponse(ScheduleResponseParams scheduleParams) async {
    final memberScheduleFacade = ref.read(groupMemberScheduleFacadeProvider);
    await memberScheduleFacade.updateResponse(scheduleParams);
  }
}
