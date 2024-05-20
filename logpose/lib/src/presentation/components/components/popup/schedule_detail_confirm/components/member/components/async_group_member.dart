import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../domain/providers/group/members/listen_group_member_profile_not_absence_list_provider.dart';

import '../../../../../../common/custom_image/custom_image.dart';

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
      listenGroupMemberProfileNotAbsenceListProvider(scheduleId),
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
