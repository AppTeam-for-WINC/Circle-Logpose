import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/auth/login_controller.dart';

final loginControllerProvider = Provider<LoginController>(
  (ref) => LoginController(),
);
