import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/common/color_exchanger.dart';
import '../../../../controller/common/time_controller.dart';
import '../../../../database/group/membership/group_membership_controller.dart';
import '../../../../database/group/schedule/member_schedule/member_schedule_controller.dart';
import '../../../../database/group/schedule/schedule/schedule_controller.dart';
import '../../../../validation/validation.dart';

final groupNameProvider =
    StateProvider.autoDispose<String>((ref) => 'No selected group');

final createGroupScheduleProvider = StateNotifierProvider.autoDispose<
    _SetGroupScheduleNotifier, _GroupScheduleViewer?>(
  (ref) => _SetGroupScheduleNotifier(),
);

final scheduleErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);

/// Schedule Object.
class _GroupScheduleViewer {
  _GroupScheduleViewer({
    this.groupId,
    this.color = const Color.fromARGB(255, 217, 0, 255),
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  })  : titleController = TextEditingController(text: title),
        placeController = TextEditingController(text: place),
        detailController = TextEditingController(text: detail),
        startAt = startAt ?? DateTime.now(),
        endAt = endAt ?? DateTime.now().add(const Duration(hours: 1));

  final String? groupId;
  final Color color;
  final TextEditingController titleController;
  final DateTime startAt;
  final DateTime endAt;
  final TextEditingController placeController;
  final TextEditingController detailController;

  // Update schedule data.
  _GroupScheduleViewer copyWith({
    String? groupId,
    Color? color,
    String? title,
    DateTime? startAt,
    DateTime? endAt,
    String? place,
    String? detail,
  }) {
    return _GroupScheduleViewer(
      groupId: groupId ?? this.groupId,
      color: color ?? this.color,
      title: title ?? titleController.text,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      place: place ?? placeController.text,
      detail: detail ?? detailController.text,
    );
  }
}

/// Set schedule to group.
class _SetGroupScheduleNotifier extends StateNotifier<_GroupScheduleViewer> {
  _SetGroupScheduleNotifier() : super(_GroupScheduleViewer());

  void initSchedule() {
    state = _GroupScheduleViewer(
      groupId: null,
      color: const Color.fromARGB(255, 217, 0, 255),
      title: '',
      place: '',
      detail: '',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  void setGroupId(String groupId) {
    state = state.copyWith(groupId: groupId);
  }

  void setColor(Color color) {
    state = state.copyWith(color: color);
  }

  void setTitle(TextEditingController title) {
    state = state.copyWith(title: title.text);
  }

  void setStartAt(DateTime startAt) {
    state = state.copyWith(startAt: startAt);
  }

  void setEndAt(DateTime endAt) {
    state = state.copyWith(endAt: endAt);
  }

  void setPlace(TextEditingController place) {
    state = state.copyWith(place: place.text);
  }

  void setDetail(TextEditingController detail) {
    state = state.copyWith(detail: detail.text);
  }
}

/// Create schedule.
class CreateGroupSchedule {
  CreateGroupSchedule._internal();
  static final CreateGroupSchedule _instance = CreateGroupSchedule._internal();
  static CreateGroupSchedule get instance => _instance;

  static Future<bool> createSchedule(
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      final titleValidation = ScheduleValidation.titleValidation(title);
      final placeValidation = ScheduleValidation.placeValidation(place);
      final detailValidation = ScheduleValidation.detailValidation(detail);
      if (!(titleValidation && placeValidation && detailValidation)) {
        return false;
      }
      final colorToString = colorToHex(color);

      if (!checkStartAtAfterEndAt(startAt, endAt)) {
        return false;
      }

      final scheduleId = await GroupScheduleController.create(
        groupId: groupId,
        title: title,
        color: colorToString,
        place: place,
        detail: detail,
        startAt: startAt,
        endAt: endAt,
      );

      final userDocIds =
          await GroupMembershipController.readAllUserDocIdWithGroupId(groupId);

      for (final userDocId in userDocIds) {
        await CreateMemberSchedules.create(
          scheduleId: scheduleId,
          userId: userDocId,
        );
      }

      debugPrint('Success: create schedule.');
      return true;
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class CreateMemberSchedules {
  CreateMemberSchedules._internal();
  static final CreateMemberSchedules _instance =
      CreateMemberSchedules._internal();
  static CreateMemberSchedules get instance => _instance;

  static Future<void> create({
    required String scheduleId,
    required String userId,
  }) async {
    try {
      // Create membership schedule by member.
      await GroupMemberScheduleController.create(
        scheduleId: scheduleId,
        userId: userId,
      );
    } on FirebaseException catch (e) {
      throw Exception('Error: $e');
    }
  }
}

/// Validation of schedule.
class ScheduleValidation {
  ScheduleValidation._internal();
  static final ScheduleValidation _instance = ScheduleValidation._internal();
  static ScheduleValidation get instance => _instance;

  static bool titleValidation(String title) {
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();

    final titleRequiredValidation = requiredValidation.validate(
      title,
      'title',
    );
    final titleMaxLength32Validation = maxLength32Validation.validate(
      title,
      'title',
    );
    if (!titleRequiredValidation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('titleError: $errorMessage');
      return false;
    }
    if (!titleMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      debugPrint('titleError: $errorMessage');
      return false;
    }

    return true;
  }

  static bool placeValidation(String place) {
    if (place.isEmpty) {
      return true;
    }
    const maxLength64Validation = MaxLength64Validation();

    final placeMaxLength64Validation = maxLength64Validation.validate(
      place,
      'place',
    );
    if (!placeMaxLength64Validation) {
      final errorMessage =
          const MaxLength64Validation().getMaxLengthInvalidMessage();

      debugPrint('placeError: $errorMessage');
      return false;
    }

    return true;
  }

  static bool detailValidation(String detail) {
    if (detail.isEmpty) {
      return true;
    }
    const maxLength2048Validation = MaxLength2048Validation();

    final detailMaxLength2048Validation = maxLength2048Validation.validate(
      detail,
      'detail',
    );
    if (!detailMaxLength2048Validation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      debugPrint('detailError: $errorMessage');
      return false;
    }
    if (!detailMaxLength2048Validation) {
      final errorMessage =
          const MaxLength2048Validation().getMaxLengthInvalidMessage();

      debugPrint('detailError: $errorMessage');
      return false;
    }

    return true;
  }
}
