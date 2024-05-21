import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/facade/group_facade.dart';

import '../../../model/group_and_id_model.dart';

final listenGroupAndIdProvider =
    StreamProvider.family<GroupAndId?, String>((ref, groupId) {
  final groupFacade = ref.read(groupFacadeProvider);

  return groupFacade.listenGroupAndId(groupId);
});
