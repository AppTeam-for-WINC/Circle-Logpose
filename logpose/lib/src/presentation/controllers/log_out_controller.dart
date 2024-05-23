import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/auth_facade.dart';

final logOutControllerProvider = Provider<LogOutController>(
  LogOutController.new,
);

class LogOutController {
  LogOutController(this.ref);
  final Ref ref;

  Future<void> logOut() async {
    final authFacade = ref.read(authFacadeProvider);
    await authFacade.logOut();
  }
}
