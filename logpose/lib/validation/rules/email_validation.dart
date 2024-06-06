import 'validation.dart';

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
