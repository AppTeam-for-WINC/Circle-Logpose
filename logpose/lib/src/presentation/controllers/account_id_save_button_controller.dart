import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/user_service_facade.dart';

final accountIdSaveButtonControllerrProvider =
    Provider<AccountIdSaveButtonController>(
  AccountIdSaveButtonController.new,
);

class AccountIdSaveButtonController {
  AccountIdSaveButtonController(this.ref);
  final Ref ref;

  Future<String?> updateAccountId(String newAccountId) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.updateAccountId(newAccountId);
  }
}
