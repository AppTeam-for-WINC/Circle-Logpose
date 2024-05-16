import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/group_repository.dart';

final groupRepositoryProvider = Provider<GroupRepository>(
  (ref) => GroupRepository.instance,
);
