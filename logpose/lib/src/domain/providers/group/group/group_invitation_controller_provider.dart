import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repository/database/invitation_repository.dart';

final groupInvitationRepositoryProvider = Provider<GroupInvitationRepository>(
  (ref) => GroupInvitationRepository.instance,
);
