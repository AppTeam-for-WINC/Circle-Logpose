import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/schedule/member_schedule/member_schedule_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Group membership users controller under condition not absence.
final groupMembershipProfileListNotAbsenceProvider =
    StreamProvider.family<List<UserProfile?>, String>((ref, scheduleId) async* {
  final myDocId = await AuthController.getCurrentUserId();
  if (myDocId == null) {
    throw Exception('User not login.');
  }

  final responsedMembershipStream =
      GroupMemberScheduleController.readAllMembershipUserDocIdByTerm(
    scheduleId,
    myDocId,
  );

  await for (final membershipProfileList in responsedMembershipStream) {
    final userProfiles = await Future.wait(
      membershipProfileList.map(
        (userDocId) async {
          if (userDocId == null) {
            return null;
          }
          return UserController.read(userDocId);
        },
      ),
    );

    yield userProfiles.whereType<UserProfile>().toList();
  }
});
