// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/loading_progress.dart';

import '../../../../controllers/providers/group/group/group_create_provider.dart';
import '../../../../controllers/providers/group/members/membership/set_group_member_list_provider.dart';
import '../../../../controllers/providers/group/schedule/image_provider.dart';
import '../../../../controllers/providers/text_field/name_field_provider.dart';

import '../../../../models/custom/group_name_and_image_and_description_model.dart';

import '../../../slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class CreateGroupButton extends ConsumerStatefulWidget {
  const CreateGroupButton({super.key});
  @override
  ConsumerState createState() => _CreateGroupButtonState();
}

class _CreateGroupButtonState extends ConsumerState<CreateGroupButton> {
  void _loadingProgress(bool loading) {
    LoadingProgressController(ref).loadingProgress = loading;
  }

  Future<String?> _createGroup() async {
    try {
      return ref.read(groupCreatorProvider).create(
        GroupNameAndImageAndDescription(
          groupName: ref.read(nameFieldProvider('')).text,
          image: ref.read(imageControllerProvider),
          description: null,
        ),
        ref.read(setGroupMemberListProvider),
      );
    } on Exception catch (e) {
      return 'Error: failed to create group. $e';
    }
  }

  Future<void> _pushAndRemoveUntil() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) {
          return const ScheduleListAndJoinedGroupTabSlider();
        },
      ),
      (_) => false,
    );
  }

  Future<void> onPressed() async {
    if (ref.watch(loadingProgressProvider)) {
      return;
    }

    _loadingProgress(true);
    final errorMessage = await _createGroup();
    _loadingProgress(false);

    if (errorMessage != null) {
      LoadingProgressController(ref).loadingErrorMessage = errorMessage;
      return;
    }

    if (!mounted) {
      return;
    }
    await _pushAndRemoveUntil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color: const Color.fromARGB(255, 107, 88, 252),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(225, 127, 145, 145),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: CupertinoColors.white,
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.add,
                  size: 25,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              '団体を作成',
              style: TextStyle(
                fontSize: 18,
                color: CupertinoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
