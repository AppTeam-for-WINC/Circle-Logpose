import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/account_id_validator.dart';

final accountIdValidatorProvider = Provider<AccountIdValidator>(
  (ref) => const AccountIdValidator(),
);
