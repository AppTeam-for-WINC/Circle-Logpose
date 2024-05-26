// ignore_for_file: one_member_abstracts

import '../../model/group_setting_params_model.dart';

abstract class IGroupUpdateUseCase {
Future<String?> updateGroup(GroupSettingParams groupData);
}
