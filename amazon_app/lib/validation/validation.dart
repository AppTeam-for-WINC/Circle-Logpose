abstract class Validation<Object> {
  const Validation();
  void validate(Object? value, String propertyName);
}

class ErrorMessages {
  static const minLength8InvalidMessage = 'Please enter at least 8 characters.';
  static const maxLength32InvalidMessage = 'Please enter up to 32 characters.';
  static const maxLength64InvalidMessage = 'Please enter up to 64 characters.';
  static const maxLength2048InvalidMessage =
      'Please enter up to 2048 characters.';
  static const requiredInvalidMessage =
      'Fields marked with an asterisk * are required';
  static const emailInvalidMessage = 'Invalid email format.';
}

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

class EmailValidation implements Validation<Object> {
  const EmailValidation();

  @override
  bool validate(Object? value, String propertyName) {
    if (value == null) {
      return false;
    }
    final result = value as String;

    if (result.isEmpty) {
      return false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(result);
  }

  String emailInvalidMessage() => ErrorMessages.emailInvalidMessage;
}
