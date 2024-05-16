import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../usecase/helper/group_and_id_fetcher_helper.dart';

final groupAndIdFetcherHelperProvider = Provider<GroupAndIdFetcherHelper>(
  (ref) => GroupAndIdFetcherHelper(ref: ref),
);
