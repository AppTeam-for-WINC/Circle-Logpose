import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/auth/signup_controller.dart';

final signUpControllerProvider = Provider<SignUpController>(
  (ref) => SignUpController(),
);
