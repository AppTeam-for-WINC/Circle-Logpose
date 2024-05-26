import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/user_profile.dart';

import '../../domain/interface/user/i_account_id_update_use_case.dart';
import '../../domain/interface/user/i_user_id_use_case.dart';
import '../../domain/interface/user/i_user_profile_update_use_case.dart';
import '../../domain/interface/user/i_user_profile_use_case.dart';

import '../../domain/model/user_setting_model.dart';

import '../../domain/usecase/usecase_user/account_id_update_use_case.dart';
import '../../domain/usecase/usecase_user/user_id_use_case.dart';
import '../../domain/usecase/usecase_user/user_profile_update_use_case.dart';
import '../../domain/usecase/usecase_user/user_profile_use_case.dart';

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
  final IUserIdUseCase _userIdUseCase;
  final IUserProfileUseCase _userProfileUseCase;
  final IUserProfileUpdateUseCase _userProfileUpdateUseCase;
  final IAccountIdUpdateUseCase _accountIdUpdateUseCase;

  Future<String> fetchUserDocIdWithAccountId(String accountId) async {
    return _userIdUseCase.fetchUserDocIdWithAccountId(accountId);
  }

  Future<UserProfile?> fetchUserProfile(String userId) async {
    return _userProfileUseCase.fetchUserProfile(userId);
  }

  Future<UserProfile?> fetchUserProfileWithAccountId(String accountId) async {
    return _userProfileUseCase.fetchUserProfileWithAccountId(accountId);
  }

  Future<String?> updateAccountId(String newAccountId) async {
    return _accountIdUpdateUseCase.updateAccountId(newAccountId);
  }

  Future<String?> updateUser(UserSettingParams userData) async {
    return _userProfileUpdateUseCase.updateUser(userData);
  }
}
