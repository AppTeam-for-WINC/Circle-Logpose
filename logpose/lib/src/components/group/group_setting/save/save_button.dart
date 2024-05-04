import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logpose/src/controllers/providers/group/schedule/image_provider.dart';

import '../../../../common/loading_progress.dart';
import '../../../../controllers/controllers/group/update/update_group_settings.dart';
import '../../../../controllers/providers/error/group_name_error_msg_provider.dart';
import '../../../../controllers/providers/text_field/name_field_provider.dart';
import '../../../slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key, required this.groupId, required this.groupName});
  final String groupId;
  final String groupName;

  @override
  ConsumerState<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  @override
  Widget build(BuildContext context) {
    Future<String?> updateGroupSetting() async {
      return UpdateGroupSettings.update(
        widget.groupId,
        ref.watch(nameFieldProvider(widget.groupName)).text,
        null,
        ref.watch(imageControllerProvider),
        ref,
      );
    }

    Future<void> pushAndRemoveUntil() async {
      await Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
          builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
        ),
        (_) => false,
      );
    }

    Future<void> save() async {
      if (ref.watch(loadingProgressProvider)) {
        return;
      }

      final errorMessage = await updateGroupSetting();
      if (errorMessage != null) {
        ref.watch(groupNameErrorMessageProvider.notifier).state = errorMessage;
        return;
      }

      if (!mounted) {
        return;
      }
      await pushAndRemoveUntil();
    }

    return CupertinoButton(
      onPressed: save,
      color: const Color(0xFF7B61FF),
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: 117,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.download,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            const Text('変更を保存'),
          ],
        ),
      ),
    );
  }
}
