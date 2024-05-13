import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user/user_setting_updater.dart';

final userSettingUpdaterProvider = Provider<UserSettingUpdater>(
  (ref) => const UserSettingUpdater(),
);
