import 'validation.dart';

class MaxLength32Validation implements Validation<Object> {
  const MaxLength32Validation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }
    final result = value as String;

    if (result.length > 32 || result.isEmpty) {
      return false;
    }

    return result.isNotEmpty;
  }

  String getStringInvalidRequiredMessage() =>
      ErrorMessages.requiredInvalidMessage;
  String getMaxLengthInvalidMessage() =>
      ErrorMessages.maxLength32InvalidMessage;
}

class MaxLength64Validation implements Validation<Object> {
  const MaxLength64Validation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }
    final result = value as String;

    if (result.length > 64 || result.isEmpty) {
      return false;
    }

    return result.isNotEmpty;
  }

  String getStringInvalidRequiredMessage() =>
      ErrorMessages.requiredInvalidMessage;
  String getMaxLengthInvalidMessage() =>
      ErrorMessages.maxLength64InvalidMessage;
}

class MaxLength2048Validation implements Validation<Object> {
  const MaxLength2048Validation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }
    final result = value as String;

    if (result.length > 2048 || result.isEmpty) {
      return false;
    }

    return result.isNotEmpty;
  }

  String getStringInvalidRequiredMessage() =>
      ErrorMessages.requiredInvalidMessage;
  String getMaxLengthInvalidMessage() =>
      ErrorMessages.maxLength2048InvalidMessage;
}
