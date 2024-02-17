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

final scheduleErrorMessageProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final createGroupScheduleProvider =
    StateNotifierProvider<_SetGroupScheduleNotifier, _GroupScheduleViewer?>(
  (ref) => _SetGroupScheduleNotifier(),
);

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

  static Future<String?> createSchedule(
    String groupId,
    String title,
    Color color,
    String place,
    String detail,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      final titleValidationErrorMessage =
          ScheduleValidation.titleValidation(title);
      final placeValidationErrorMessage =
          ScheduleValidation.placeValidation(place);
      final detailValidationErrorMessage =
          ScheduleValidation.detailValidation(detail);
      if (titleValidationErrorMessage != null) {
        return titleValidationErrorMessage;
      }

      if (placeValidationErrorMessage != null) {
        return placeValidationErrorMessage;
      }

      if (detailValidationErrorMessage != null) {
        return detailValidationErrorMessage;
      }

      final colorToString = colorToHex(color);

      if (!checkStartAtAfterEndAt(startAt, endAt)) {
        const errorMessage = 'Start time must be set before end time';
        return errorMessage;
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

      return null;
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

  static String? titleValidation(String title) {
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

      return errorMessage;
    }
    if (!titleMaxLength32Validation) {
      final errorMessage =
          const MaxLength32Validation().getMaxLengthInvalidMessage();

      return errorMessage;
    }

    return null;
  }

  static String? placeValidation(String place) {
    if (place.isEmpty) {
      return null;
    }
    const maxLength64Validation = MaxLength64Validation();

    final placeMaxLength64Validation = maxLength64Validation.validate(
      place,
      'place',
    );
    if (!placeMaxLength64Validation) {
      final errorMessage =
          const MaxLength64Validation().getMaxLengthInvalidMessage();

      return errorMessage;
    }

    return null;
  }

  static String? detailValidation(String detail) {
    if (detail.isEmpty) {
      return null;
    }
    const maxLength2048Validation = MaxLength2048Validation();

    final detailMaxLength2048Validation = maxLength2048Validation.validate(
      detail,
      'detail',
    );
    if (!detailMaxLength2048Validation) {
      final errorMessage =
          const RequiredValidation().getStringInvalidRequiredMessage();

      return errorMessage;
    }
    if (!detailMaxLength2048Validation) {
      final errorMessage =
          const MaxLength2048Validation().getMaxLengthInvalidMessage();

      return errorMessage;
    }

    return null;
  }
}
