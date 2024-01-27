import 'package:amazon_app/database/auth/auth_controller.dart';
import 'package:amazon_app/database/group/membership/group_membership_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final checkGroupExistProvider = FutureProvider<bool>((ref) async{
  final userDocId = await AuthController.getCurrentUserId();
  if (userDocId == null) {
    throw Exception('User not logged in.');
  }
  final groupIsExist =
      await GroupMembershipController.readAllWithUserId(userDocId);
  
  if (groupIsExist.isNotEmpty) {
    return true;
  }

  return false;
});
