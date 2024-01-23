import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/pages/popup/member_add/member_add_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberAddDataProvider =
    StateNotifierProvider<MemberAddData, UserProfile?>(
  (ref) => MemberAddData(),
);
