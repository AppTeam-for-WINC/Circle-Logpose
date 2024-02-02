import 'package:amazon_app/controller/common/time_controller.dart';
import 'package:amazon_app/database/schedule/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createGroupScheduleProvider =
    StateNotifierProvider<_CreateGroupScheduleNotifier, GroupSchedule?>(
  (ref) => _CreateGroupScheduleNotifier(),
);

class _CreateGroupScheduleNotifier extends StateNotifier<GroupSchedule?> {
  _CreateGroupScheduleNotifier() : super(null);

  TextEditingController titleController = TextEditingController();
  String color = Colors.white.toString();
  String startAt = formatDateTime(DateTime.now());
  String endAt = formatDateTime(
    DateTime.now().add(
      const Duration(hours: 1),
    ),
  );
  TextEditingController placeController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Map<String?, dynamic> _valueChecker(
    String? groupId,
    String? title,
    String? color,
    String? place,
    String? detail,
    DateTime? startAt,
    DateTime? endAt,
  ) {
    if (state != null) {
      final newGroupId = groupId ?? state!.groupId;
      final newTitle = title ?? state!.title;
      final newColor = color ?? state!.color;
      final newPlace = place ?? state!.place;
      final newDetail = detail ?? state!.detail;
      final newStartAt = startAt ?? state!.startAt;
      final newEndAt = endAt ?? state!.endAt;
      return {
        'groupId': newGroupId,
        'title': newTitle,
        'color': newColor,
        'place': newPlace,
        'detail': newDetail,
        'startAt': newStartAt,
        'endAt': newEndAt,
      };
    } else {
      throw Exception('Exception: State is not correct.');
    }
  }

  ///Before deployment
  Future<bool> setSchedule(
    String? groupId,
  ) async {
    if (state != null) {
      final values = _valueChecker(
        groupId,
        titleController.text,
        color,
        placeController.text,
        detailController.text,
        formatString(startAt),
        formatString(endAt),
      );

      state = GroupSchedule(
        groupId: values['groupId'] as String,
        title: values['title'] as String,
        color: values['color'] as String,
        place: values['place'] as String,
        detail: values['detail'] as String,
        startAt: values['startAt'] as DateTime,
        endAt: values['endAt'] as DateTime,
        createdAt: state!.createdAt,
      );
      return true;
    }
    return false;
  }

  Future<bool> createSchedule() async {
    return false;
  }
}
