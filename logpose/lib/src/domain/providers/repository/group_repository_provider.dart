import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/group_repository.dart';

import '../../interface/i_group_repository.dart';

final groupRepositoryProvider = Provider<IGroupRepository>(
  (ref) => GroupRepository(ref: ref),
);
