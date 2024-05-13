import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user/account_id_updater.dart';

final accountIdUpdaterProvider = Provider<AccountIdUpdater>(
  (ref) => const AccountIdUpdater(),
);
