import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth/auth_management_controller.dart';

final userEmailNotifierProvider =
    StateNotifierProvider.autoDispose<_UserProfileNotifier, String>(
  _UserProfileNotifier.new,
);

class _UserProfileNotifier extends StateNotifier<String> {
  _UserProfileNotifier(this.ref) : super('') {
    _init();
  }

  final Ref ref;

  Future<void> _init() async {
    try {
      await _executeToInit();
    } on Exception catch (e) {
      throw Exception('Error read user data: $e');
    }
  }

  Future<void> _executeToInit() async {
    final authController = ref.read(authManagementControllerProvider);
    final email = await authController.fetchUserEmail();
    if (email == null) {
      return;
    }

    if (mounted) {
      state = email;
    }
  }
}
