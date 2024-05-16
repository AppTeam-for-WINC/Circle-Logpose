import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../validator/group_validator.dart';

final groupValidatorProvider = Provider<GroupValidator>(
  (ref) => const GroupValidator(),
);
