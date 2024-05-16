import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../validator/validator_controller.dart';
import 'account_id_validator_provider.dart';
import 'credentials_validator_provider.dart';
import 'group_validator_provider.dart';
import 'schedule_validator_provider.dart';
import 'username_validator_provider.dart';

final validatorControllerProvider = Provider<ValidatorController>(
  (ref) {
    final credentialsValidator = ref.read(credentialsValidatorProvider);
    final groupValidator = ref.read(groupValidatorProvider);
    final scheduleValidator = ref.read(scheduleValidatorProvider);
    final usernameValidator = ref.read(usernameValidatorProvider);
    final accountIdValidator = ref.read(accountIdValidatorProvider);

    return ValidatorController(
      credentialsValidator: credentialsValidator,
      groupValidator: groupValidator,
      scheduleValidator: scheduleValidator,
      usernameValidator: usernameValidator,
      accountIdValidator: accountIdValidator,
    );
  }
);
