import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/credentials_validator.dart';

final credentialsValidatorProvider = Provider<CredentialsValidator>(
  (ref) => const CredentialsValidator(),
);
