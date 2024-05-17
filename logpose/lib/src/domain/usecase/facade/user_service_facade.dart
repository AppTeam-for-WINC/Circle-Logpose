import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

import '../../../models/custom/user_setting_model.dart';

import '../usecase_user/account_id_update_use_case.dart';
import '../usecase_user/user_id_use_case.dart';
import '../usecase_user/user_profile_update_use_case.dart';
import '../usecase_user/user_profile_use_case.dart';

/// Facade pattern （ファサードパターン）
final userServiceFacadeProvider = Provider<UserServiceFacade>(
  (ref) => UserServiceFacade(ref: ref),
);

class UserServiceFacade {
  UserServiceFacade({required this.ref})
      : _userIdUseCase = ref.read(userIdUseCaseProvider),
        _userProfileUseCase = ref.read(userProfileUseCaseProvider),
        _userProfileUpdateUseCase = ref.read(userProfileUpdateUseCaseProvider),
        _accountIdUpdateUseCase = ref.read(accountIdUpdateUseCaseProvider);

  final Ref ref;
  final UserIdUseCase _userIdUseCase;
  final UserProfileUseCase _userProfileUseCase;
  final UserProfileUpdateUseCase _userProfileUpdateUseCase;
  final AccountIdUpdateUseCase _accountIdUpdateUseCase;

  Future<String> fetchCurrentUserId() async {
    return _userIdUseCase.fetchCurrentUserId();
  }

  Future<String?> fetchCurrentUserIdNullable() async {
    return _userIdUseCase.fetchCurrentUserIdNullable();
  }

  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    return _userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<UserProfile> fetchUserProfile(String userId) async {
    return _userProfileUseCase.fetchUserProfile(userId);
  }

  Future<UserProfile> fetchUserProfileWithAccountId(String accountId) async {
    return _userProfileUseCase.fetchUserProfileWithAccountId(accountId);
  }

  Future<String?> updateAccountId(String newAccountId) async {
    return _accountIdUpdateUseCase.updateAccountId(newAccountId);
  }

  Future<String?> updateUser(UserSettingParams userData) async {
    return _userProfileUpdateUseCase.updateUser(userData);
  }
}
