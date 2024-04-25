import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Switch mode of delete set member.
final groupMemberDeleteModeProvider =
    StateProvider.autoDispose<bool>((ref) => false);
