import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../validation/validator/validator_controller.dart';

import '../../../data/interface/i_auth_repository.dart';
import '../../../data/interface/i_user_repository.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../../data/repository/database/user_repository.dart';

import '../../interface/auth/I_account_deletion_use_case.dart';
import '../../interface/auth/i_auth_user_id_use_case.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_delete_use_case.dart';
import '../../interface/group_member_schedule/i_group_member_schedule_id_use_case.dart';
import '../../interface/group_membership/i_group_member_delete_use_case.dart';
import '../../interface/group_membership/i_group_member_id_use_case.dart';

import '../usecase_group_membership/group_member_delete_use_case.dart';
import '../usecase_group_membership/group_member_id_use_case.dart';
import '../usecase_member_schedule/group_member_schedule_delete_use_case.dart';
import '../usecase_member_schedule/group_member_schedule_id_use_case.dart';
import 'user_id_use_case.dart';

final accountDeletionUseCaseProvider = Provider<IAccountDeletionUseCase>((ref) {
  final authUserIdUseCase = ref.read(authUserIdUseCaseProvider);
  final groupMemberIdUseCase = ref.read(groupMemberIdUseCaseProvider);
  final groupMemberDeleteUseCase = ref.read(groupMemberDeleteUseCaseProvider);
  final groupMemberScheduleIdUseCase =
      ref.read(groupMemberScheduleIdUseCaseProvider);
  final groupMemberScheduleDeleteUseCase =
      ref.read(groupMemberScheduleDeleteUseCaseProvider);
  final authRepository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final validator = ref.read(validatorControllerProvider);

  return AccountDeletionUseCase(
    ref: ref,
    authUserIdUseCase: authUserIdUseCase,
    groupMemberIdUseCase: groupMemberIdUseCase,
    groupMemberDeleteUseCase: groupMemberDeleteUseCase,
    groupMemberScheduleIdUseCase: groupMemberScheduleIdUseCase,
    groupMemberScheduleDeleteUseCase: groupMemberScheduleDeleteUseCase,
    authRepository: authRepository,
    userRepository: userRepository,
    validator: validator,
  );
});

class AccountDeletionUseCase implements IAccountDeletionUseCase {
  AccountDeletionUseCase({
    required this.ref,
    required this.authUserIdUseCase,
    required this.groupMemberIdUseCase,
    required this.groupMemberDeleteUseCase,
    required this.groupMemberScheduleIdUseCase,
    required this.groupMemberScheduleDeleteUseCase,
    required this.authRepository,
    required this.userRepository,
    required this.validator,
  });

  final Ref ref;
  final IAuthUserIdUseCase authUserIdUseCase;
  final IGroupMemberIdUseCase groupMemberIdUseCase;
  final IGroupMemberScheduleIdUseCase groupMemberScheduleIdUseCase;
  final IGroupMemberDeleteUseCase groupMemberDeleteUseCase;
  final IGroupMemberScheduleDeleteUseCase groupMemberScheduleDeleteUseCase;
  final IAuthRepository authRepository;
  final IUserRepository userRepository;
  final ValidatorController validator;

  @override
  Future<String?> deleteAccount(String email, String password) async {
    try {
      final credentialsValidation =
          validator.validateCredentials(email, password);

      if (credentialsValidation != null) {
        return credentialsValidation;
      }

      final userId = await _fetchUserDocId();
      await _deleteMemberScheduleList(userId);
      await _deleteMemberList(userId);
      await _deleteUser(userId);
      await _deleteAccount(email, password);

      return null;
    } on FirebaseException catch (e) {
      throw Exception('Error: failed to fetch user email. ${e.message}');
    }
  }

  Future<String> _fetchUserDocId() async {
    return authUserIdUseCase.fetchCurrentUserId();
  }

  Future<void> _deleteMemberScheduleList(String userId) async {
    final memberScheduleIdList =
        await _fetchMemberScheduleIdListWithUserId(userId);

    if (memberScheduleIdList == null) {
      return;
    }

    await memberScheduleIdList.map(_deleteMemberSchedule);
  }

  Future<List<String>?> _fetchMemberScheduleIdListWithUserId(
      String userId) async {
    return await groupMemberScheduleIdUseCase
        .fetchMemberScheduleIdListWithUserId(userId);
  }

  Future<void> _deleteMemberSchedule(String memberScheduleId) async {
    await groupMemberScheduleDeleteUseCase
        .deleteMemberSchedule(memberScheduleId);
  }

  Future<void> _deleteMemberList(String userId) async {
    final membershipIdList = await _fetchMembershipIdListWithUserId(userId);
    if (membershipIdList == null) {
      return;
    }
    await membershipIdList.map(_deleteMember);
  }

  Future<List<String>?> _fetchMembershipIdListWithUserId(String userId) async {
    return groupMemberIdUseCase.fetchMembershipIdListWithUserId(userId);
  }

  Future<void> _deleteMember(String membershipDocId) async {
    await groupMemberDeleteUseCase.deleteMember(membershipDocId);
  }

  Future<void> _deleteUser(String userId) async {
    await userRepository.deleteUser(userId);
  }

  Future<void> _deleteAccount(String email, String password) async {
    await authRepository.deleteAccount(email, password);
  }
}
