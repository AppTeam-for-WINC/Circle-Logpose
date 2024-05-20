import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../domain/model/group_setting_params_model.dart';

import '../../../../../../domain/providers/error_message/group_name_error_msg_provider.dart';
import '../../../../../../domain/providers/image_provider.dart';
import '../../../../../../domain/providers/text_field/name_field_provider.dart';

import '../../../../../../domain/usecase/facade/group_facade.dart';

import '../../../../../notifiers/set_group_member_list_notifier.dart';

import '../../../../common/loading_progress.dart';

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
      final groupFacade = ref.read(groupFacadeProvider);
      return groupFacade.updateGroup(
        GroupSettingParams(
          groupId: widget.groupId,
          groupName: ref.read(nameFieldProvider(widget.groupName)).text,
          image: ref.read(imageControllerProvider),
          description: null,
          memberList: ref.read(setGroupMemberListNotifierProvider),
        ),
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
              child: const Icon(Icons.download, color: Colors.black),
            ),
            const SizedBox(width: 10),
            const Text('変更を保存'),
          ],
        ),
      ),
    );
  }
}
