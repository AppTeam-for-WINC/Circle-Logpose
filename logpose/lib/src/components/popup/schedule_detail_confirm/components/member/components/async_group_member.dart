import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common/custom_image/custom_image.dart';
import '../../../../../../controllers/providers/group/schedule/watch_group_member_profile_not_absence_list_provider.dart';

class AsyncGroupMember extends ConsumerStatefulWidget {
  const AsyncGroupMember({
    super.key,
    required this.scheduleId,
  });

  final String scheduleId;
  @override
  ConsumerState createState() => _AsyncGroupMemberState();
}

class _AsyncGroupMemberState extends ConsumerState<AsyncGroupMember> {
  @override
  Widget build(BuildContext context) {
    final scheduleId = widget.scheduleId;
    final asyncGroupMember = ref.watch(
      watchGroupMembershipProfileNotAbsenceListProvider(scheduleId),
    );

    return asyncGroupMember.when(
      data: (membershipProfileList) {
        return Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Row(
            children: membershipProfileList.map((membershipProfile) {
              return membershipProfile != null
                  ? CustomImage(
                      imagePath: membershipProfile.image,
                      width: 30,
                      height: 30,
                    )
                  : const SizedBox.shrink();
            }).toList(),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Text('$error'),
    );
  }
}
