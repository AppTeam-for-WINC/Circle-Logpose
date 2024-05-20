import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'validation/group_validation.dart';

final groupValidatorProvider = Provider<GroupValidator>(
  (ref) => const GroupValidator(),
);

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
