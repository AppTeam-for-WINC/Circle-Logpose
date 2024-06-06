import 'validation.dart';

class MinLength8Validation implements Validation<Object> {
  const MinLength8Validation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }
    final result = value as String;

    if (result.length < 8 || result.isEmpty) {
      return false;
    }

    return result.isNotEmpty;
  }

  String getStringInvalidRequiredMessage() =>
      ErrorMessages.requiredInvalidMessage;
  String getMinLengthInvalidMessage() => ErrorMessages.minLength8InvalidMessage;
}
