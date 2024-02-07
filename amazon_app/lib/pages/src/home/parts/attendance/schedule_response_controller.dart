// import 'package:amazon_app/database/auth/auth_controller.dart';
// import 'package:amazon_app/database/group/schedule/member_schedule/member_schedule.dart';
// import 'package:amazon_app/database/group/schedule/member_schedule/member_schedule_controller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final userResponseProvider =
//     StateNotifierProvider<_SetResponseScheduleNotifier, GroupMemberSchedule?>(
//   (ref) => _SetResponseScheduleNotifier(),
// );

// /// Update schedule response
// class _SetResponseScheduleNotifier extends StateNotifier<GroupMemberSchedule?> {
//   _SetResponseScheduleNotifier() : super(null) {
//     _initResponse();
//   }

//   Future<void> _initResponse(String scheduleId) async {
//     final myDocId = await AuthController.getCurrentUserId();
//     await GroupMemberScheduleController.create();
//   }
// }



// ちょっと考える