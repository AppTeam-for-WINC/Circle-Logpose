import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/group/update/group_setting_updater.dart';

final groupSettingUpdaterProvider = Provider<GroupSettingUpdater>(
  (ref) => const GroupSettingUpdater(),
);
