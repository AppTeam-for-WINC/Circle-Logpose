import '../validation/group/group_validation.dart';

class GroupValidator {
  const GroupValidator();

  static String? _validateName(String groupName) {
    return GroupValidation.validateName(groupName);
  }

  String? validateGroup(String groupName) {
    final nameError = _validateName(groupName);
    if (nameError != null) {
      return nameError;
    }
    return null;
  }
}
