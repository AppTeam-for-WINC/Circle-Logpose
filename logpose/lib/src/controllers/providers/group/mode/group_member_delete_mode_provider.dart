import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Switch mode of delete set member.
final setMemberDeleteModeProvider =
    StateProvider.autoDispose<bool>((ref) => false);
