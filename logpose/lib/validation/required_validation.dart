import 'validation.dart';

class RequiredValidation implements Validation<Object> {
  const RequiredValidation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }

    final result = value as String;

    if (result.isEmpty) {
      return false;
    }

    return result.trim().isNotEmpty;
  }

  String getStringInvalidRequiredMessage() =>
      ErrorMessages.requiredInvalidMessage;
}
