import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/facade/user_service_facade.dart';
import '../../domain/model/user_setting_model.dart';

final userSettingUpdaterController = Provider<UserSettingUpdaterController>(
  UserSettingUpdaterController.new,
);

class UserSettingUpdaterController {
  UserSettingUpdaterController(this.ref);

  final Ref ref;

  Future<String?> update(UserSettingParams userData) async {
    final userServiceFacade = ref.read(userServiceFacadeProvider);
    return userServiceFacade.updateUser(userData);
  }
}
