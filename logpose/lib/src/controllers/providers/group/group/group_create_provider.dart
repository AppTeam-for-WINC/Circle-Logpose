import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/create/group_creator.dart';

final groupCreatorProvider = Provider<GroupCreator>(
  (ref) => const GroupCreator(),
);
