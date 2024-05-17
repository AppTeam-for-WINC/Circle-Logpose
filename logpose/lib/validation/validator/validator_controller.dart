import '../../src/models/custom/schedule_validation_params.dart';

import 'account_id_validator.dart';
import 'credentials_validator.dart';
import 'group_validator.dart';
import 'schedule_validator.dart';
import 'username_validator.dart';

class ValidatorController {
  const ValidatorController({
    required this.credentialsValidator,
    required this.groupValidator,
    required this.scheduleValidator,
    required this.usernameValidator,
    required this.accountIdValidator,
  });
  final CredentialsValidator credentialsValidator;
  final GroupValidator groupValidator;
  final ScheduleValidator scheduleValidator;
  final UsernameValidator usernameValidator;
  final AccountIdValidator accountIdValidator;

  String? validateCredentials(String email, String password) {
    return credentialsValidator.validateCredentials(email, password);
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
