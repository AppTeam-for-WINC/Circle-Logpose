import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/facade/auth_facade.dart';

final fetchUserEmailProvider = FutureProvider<String>((ref) async {
  final authFacade = ref.watch(authFacadeProvider);
  final email = await authFacade.fetchUserEmail();

  if (email == null) {
    throw Exception('Error: failed to fetch email.');
  }

  return email;
});
