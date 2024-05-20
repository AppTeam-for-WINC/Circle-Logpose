import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/domain/model/schedule_validation_params.dart';

import 'account_id_validator.dart';
import 'credentials_validator.dart';
import 'group_validator.dart';
import 'password_validator.dart';
import 'schedule_validator.dart';
import 'username_validator.dart';

final validatorControllerProvider = Provider<ValidatorController>(
  (ref) {
    final credentialsValidator = ref.read(credentialsValidatorProvider);
    final passwordValidator = ref.read(passwordValidatorProvider);
    final groupValidator = ref.read(groupValidatorProvider);
    final scheduleValidator = ref.read(scheduleValidatorProvider);
    final usernameValidator = ref.read(usernameValidatorProvider);
    final accountIdValidator = ref.read(accountIdValidatorProvider);

    return ValidatorController(
      credentialsValidator: credentialsValidator,
      passwordValidator: passwordValidator,
      groupValidator: groupValidator,
      scheduleValidator: scheduleValidator,
      usernameValidator: usernameValidator,
      accountIdValidator: accountIdValidator,
    );
  }
);

class ValidatorController {
  const ValidatorController({
    required this.credentialsValidator,
    required this.passwordValidator,
    required this.groupValidator,
    required this.scheduleValidator,
    required this.usernameValidator,
    required this.accountIdValidator,
  });
  final CredentialsValidator credentialsValidator;
  final PasswordValidator passwordValidator;
  final GroupValidator groupValidator;
  final ScheduleValidator scheduleValidator;
  final UsernameValidator usernameValidator;
  final AccountIdValidator accountIdValidator;

  String? validateCredentials(String email, String password) {
    return credentialsValidator.validateCredentials(email, password);
  }

  String? validatePassword(String password) {
    return passwordValidator.validatePassword(password);
  }

  String? validateGroup(String name) {
    return groupValidator.validateGroup(name);
  }

  String? validateSchedule(ScheduleValidationParams schedule) {
    return scheduleValidator.validateSchedule(schedule);
  }

  String? validateUsername(String name) {
    return usernameValidator.validateUser(name);
  }

  String? validateAccountId(String accountId) {
    return accountIdValidator.validateAccountId(accountId);
  }
}
