import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_member_creation_helper.dart';

final groupMemberCreationHelperProvider =
    Provider<GroupMemberCreationHelper>(
  (ref) => GroupMemberCreationHelper(ref: ref),
);
