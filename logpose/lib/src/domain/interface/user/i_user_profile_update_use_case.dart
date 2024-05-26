// ignore_for_file: one_member_abstracts

import '../../model/user_setting_model.dart';

abstract class IUserProfileUpdateUseCase {
  Future<String?> updateUser(UserSettingParams userData);
}
