import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/user_service_facade.dart';

import '../../../domain/model/user_setting_model.dart';

final userUpdateControllerProvider =
    Provider<UserUpdateController>(UserUpdateController.new);

class UserUpdateController {
  UserUpdateController(this.ref);

  final Ref ref;

  Future<String?> updateAccountId(String newAccountId) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.updateAccountId(newAccountId);
  }

  Future<String?> updateUser(UserSettingParams userData) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.updateUser(userData);
  }
}
