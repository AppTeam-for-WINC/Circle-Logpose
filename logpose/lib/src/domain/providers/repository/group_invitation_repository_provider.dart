import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/invitation_repository.dart';
import '../../interface/i_group_invitation_repository.dart';

final groupInvitationRepositoryProvider = Provider<IGroupInvitationRepository>(
  (ref) => GroupInvitationRepository.instance,
);
