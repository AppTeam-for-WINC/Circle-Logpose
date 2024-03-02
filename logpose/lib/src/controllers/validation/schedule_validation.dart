import '../../../validation/max_length_validation.dart';
import '../../../validation/required_validation.dart';

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
