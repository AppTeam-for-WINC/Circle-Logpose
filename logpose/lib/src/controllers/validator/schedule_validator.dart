import '../../domain/validation/schedule_validation.dart';
import '../../models/custom/schedule_validation_params.dart';
import '../../utils/time/time_utils.dart';

class ScheduleValidator {
  const ScheduleValidator();

  static String? _validateTitle(String title) {
    return ScheduleValidation.titleValidation(title);
  }

  static String? _validatePlace(String place) {
    return ScheduleValidation.titleValidation(place);
  }

  static String? _validateDetail(String detail) {
    return ScheduleValidation.detailValidation(detail);
  }

  static String? _validateTime(DateTime startAt, DateTime endAt) {
    final timeValidation = _checkStartAtAfterEndAt(startAt, endAt);
    if (!timeValidation) {
      return 'Start time must be set before end time';
    }
    return null;
  }

  static bool _checkStartAtAfterEndAt(DateTime startAt, DateTime endAt) {
    return checkStartAtAfterEndAt(startAt, endAt);
  }

  String? validateSchedule(ScheduleValidationParams schedule) {
    final titleError = _validateTitle(schedule.title);
    if (titleError != null) {
      return titleError;
    }

    final placeError = _validatePlace(schedule.place);
    if (placeError != null) {
      return placeError;
    }

    final detailError = _validateDetail(schedule.detail);
    if (detailError != null) {
      return detailError;
    }

    final timeError = _validateTime(schedule.startAt, schedule.endAt);
    if (timeError != null) {
      return timeError;
    }

    return null;
  }
}
