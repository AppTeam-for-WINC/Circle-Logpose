import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/auth_use_case.dart';
import '../../../usecase/helper/user_update_helper.dart';
import '../../../usecase/user_use_case.dart';

import '../../validator/validator_controller_provider.dart';

final userUpdateHelperProvider = Provider<UserUpdateHelper>((ref) {
  final authUseCase = ref.read(authUseCaseProvider);
  final userUseCase = ref.read(userUseCaseProvider);
  final validator = ref.read(validatorControllerProvider);

  return UserUpdateHelper(
    ref: ref,
    authUseCase: authUseCase,
    userUseCase: userUseCase,
    validator: validator,
  );
});
