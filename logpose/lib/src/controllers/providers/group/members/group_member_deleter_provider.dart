import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/delete/group_member_deleter.dart';

final groupMemberDeleterProvider = Provider<GroupMemberDeleter>(
  (ref) => const GroupMemberDeleter(),
);
