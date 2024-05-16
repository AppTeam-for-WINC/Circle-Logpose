import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/auth_use_case.dart';
import '../../usecase/sign_up_use_case.dart';

import '../validator/validator_controller_provider.dart';

final signUpUsecaseProvider = Provider<SignUpUseCase>(
  (ref) {
    final authUseCase = ref.read(authUseCaseProvider);
    final validator = ref.read(validatorControllerProvider);

    return SignUpUseCase(
      authUseCase: authUseCase,
      validator: validator,
    );
  },
);
