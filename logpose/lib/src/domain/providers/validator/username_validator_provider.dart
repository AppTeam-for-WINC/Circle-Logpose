import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../validator/username_validator.dart';

final usernameValidatorProvider = Provider<UsernameValidator>(
  (ref) => const UsernameValidator(),
);
