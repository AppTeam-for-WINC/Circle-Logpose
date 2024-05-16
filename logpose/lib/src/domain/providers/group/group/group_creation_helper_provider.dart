import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_creation_helper.dart';

final groupCreationHelperProvider = Provider<GroupCreationHelper>(
  (ref) => GroupCreationHelper(ref: ref),
);
