import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../notifiers/search_user_notifier_provider.dart';
import 'components/user_search_field.dart';

class UserSearchFieldSection extends ConsumerStatefulWidget {
  const UserSearchFieldSection({
    super.key,
    required this.groupId,
  });

  final String? groupId;

  @override
  ConsumerState<UserSearchFieldSection> createState() =>
      _UserSearchFieldSectionState();
}

class _UserSearchFieldSectionState
    extends ConsumerState<UserSearchFieldSection> {
  @override
  Widget build(BuildContext context) {
    final userProfileNotifier =
        ref.watch(searchUserNotifierProvider(widget.groupId).notifier);

    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
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
        child: UserSearchField(
          accountIdController: userProfileNotifier.accountIdController,
        ),
      ),
    );
  }
}
