import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/user/user.dart';
import 'package:amazon_app/database/user/user_controller.dart';
import 'package:amazon_app/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupMemberCountProvider = StateProvider<int>((ref) => 1);

void memberCounter(WidgetRef ref, String accountId) {
  ref.read(groupMemberCountProvider.notifier).state += 1;
}


final groupAdminMemberProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final user = await UserController.read(userDocId);
  
  return user;
});


final groupAdminMemberProfileProviderOld =
    Provider<GroupAdminUserProfile>((ref) => GroupAdminUserProfile());

class GroupAdminUserProfile {
  GroupAdminUserProfile() {
    getGroupAdminUserProfile();
  }

  String? accountId;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  void getGroupAdminUserProfile() {
    accountId = user!.accountId;
    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    print('user: $user');
    print('accountId: $accountId');
    print('userImage: $userImage');
  }
}

final groupAddDataProvider = StateNotifierProvider<GroupAddData, UserProfile?>(
  (ref) => GroupAddData(),
);

class GroupAddData extends StateNotifier<UserProfile?> {
  GroupAddData() : super(null) {
    groupNameController.addListener(groupDataController);
  }

  TextEditingController groupNameController = TextEditingController();
  String? accountId;
  List<UserProfile>? users;
  UserProfile? user;
  String? username;
  String? userImage;
  String? userDescription;

  Future<void> groupDataController() async {
    await groupNameLengthChecker();
    await memberController(accountId);
  }

  Future<String?> groupNameLengthChecker() async {
    final groupName = groupNameController.text;
    const requiredValidation = RequiredValidation();
    const maxLength32Validation = MaxLength32Validation();
    final requiredValidationValidation = requiredValidation.validate(
      groupName,
      'groupName',
    );
    final groupNameMaxLength32Validation = maxLength32Validation.validate(
      groupName,
      'groupName',
    );
    if (requiredValidationValidation && groupNameMaxLength32Validation) {
      return null;
    }

    return 'Please specify within 32 characters.';
  }

  Future<void> memberController(String? accountId) async {
    if (accountId == null) {
      return;
    }
    users = await UserController.readWithAccountId(accountId);
    user = users!.first;
    username = user!.name;
    userImage = user!.image;
    userDescription = user!.description;
    state = users!.isNotEmpty ? users!.first : null;
  }
}
