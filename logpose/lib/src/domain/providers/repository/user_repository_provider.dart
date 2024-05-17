import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/user_repository.dart';
import '../../interface/i_user_repository.dart';

final userRepositoryProvider = Provider<IUserRepository>(
  (ref) => UserRepository(ref: ref),
);
