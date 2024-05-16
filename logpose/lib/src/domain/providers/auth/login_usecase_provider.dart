import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/auth_use_case.dart';
import '../../usecase/login_use_case.dart';
import '../validator/validator_controller_provider.dart';

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) {
    final authUsecase = ref.read(authUseCaseProvider);
    final validator = ref.read(validatorControllerProvider);
    return LoginUseCase(
      authUsecase: authUsecase,
      validator: validator,
    );
  },
);
