import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/group_and_id_model.dart';

import '../../../usecase/facade/group_facade.dart';

final listenGroupAndIdProvider =
    StreamProvider.family<GroupAndId?, String>((ref, groupId) {
  final groupFacade = ref.read(groupFacadeProvider);

  return groupFacade.listenGroupAndId(groupId);
});
