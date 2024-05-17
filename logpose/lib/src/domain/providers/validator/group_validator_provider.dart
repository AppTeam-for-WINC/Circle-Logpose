import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/group_validator.dart';

final groupValidatorProvider = Provider<GroupValidator>(
  (ref) => const GroupValidator(),
);
