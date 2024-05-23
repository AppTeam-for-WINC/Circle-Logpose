import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/user/fetch_user_email_provider.dart';

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
    state = await ref.read(fetchUserEmailProvider.future);
  }
}
