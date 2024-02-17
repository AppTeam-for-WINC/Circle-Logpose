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
