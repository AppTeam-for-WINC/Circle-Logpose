import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/delete/group_deleter.dart';

final groupDeleterProvider = Provider<GroupDeleter>(
  (ref) => const GroupDeleter(),
);
