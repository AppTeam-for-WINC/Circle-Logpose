import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/database/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository.instance,
);
