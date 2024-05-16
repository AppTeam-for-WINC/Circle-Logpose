import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom/user_setting_model.dart';
import '../../models/database/user/user.dart';

import '../providers/group/group/account_id_update_helper_provider.dart';
import '../providers/group/group/user_setting_updater_provider.dart';
import '../providers/user/user_controller_provider.dart';

import 'helper/account_id_update_helper.dart';
import 'helper/user_update_helper.dart';

final userUseCaseProvider = Provider<UserUseCase>(
  (ref) => UserUseCase(ref: ref),
);

class UserUseCase {
  UserUseCase({required this.ref})
      : _accountIdUpdateHelper = ref.read(accountIdUpdateHelperProvider),
        _userUpdateHelper = ref.read(userUpdateHelperProvider);

  final Ref ref;
  final AccountIdUpdateHelper _accountIdUpdateHelper;
  final UserUpdateHelper _userUpdateHelper;

  Future<String> fetchUserDocId(String accountId) async {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.fetchUserDocIdWithAccountId(accountId);
  }

  Future<UserProfile> fetchUserProfile(String userId) async {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.fetch(userId);
  }

  Future<UserProfile> fetchUserProfileWithAccountId(String accountId) async {
    final userRepository = ref.read(userRepositoryProvider);

    final userProfile =
        await userRepository.fetchUserProfileWithAccountId(accountId);

    if (userProfile == null) {
      throw Exception('Failed to user profile.');
    }
    return userProfile;
  }

  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    final userRepository = ref.read(userRepositoryProvider);
    return userRepository.fetchUserDocIdWithAccountId(accountId);
  }

  Future<String?> updateAccountId(String newAccountId) async {
    return _accountIdUpdateHelper.updateAccountId(newAccountId);
  }

  Future<String?> updateUser(UserSettingParams userData) async {
    return _userUpdateHelper.updateUser(userData);
  }
}
