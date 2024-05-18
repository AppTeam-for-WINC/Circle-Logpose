import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../domain/providers/user/set_search_user_data_provider.dart';

class UserProfileSearchField extends ConsumerStatefulWidget {
  const UserProfileSearchField({
    super.key,
    required this.groupId,
  });
  final String? groupId;

  @override
  ConsumerState<UserProfileSearchField> createState() =>
      _UserProfileSearchFieldState();
}

class _UserProfileSearchFieldState
    extends ConsumerState<UserProfileSearchField> {
  @override
  Widget build(BuildContext context) {
    final userProfileNotifier =
        ref.watch(setSearchUserDataProvider(widget.groupId).notifier);

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 10,
        right: 20,
        bottom: 10,
      ),
      color: const Color(0xFFF5F3FE),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 219, 251),
          borderRadius: BorderRadius.circular(80),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD9D9D9),
              offset: Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CupertinoTextField(
          controller: userProfileNotifier.accountIdController,
          prefix: const Icon(CupertinoIcons.search),
          style: const TextStyle(fontSize: 16),
          placeholder: 'ユーザIDの検索',
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 244, 219, 251),
            borderRadius: BorderRadius.circular(80),
          ),
          autofocus: true,
        ),
      ),
    );
  }
}
