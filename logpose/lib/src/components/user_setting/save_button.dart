import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/loading_progress.dart';
import '../../controllers/controllers/user/update_user_profile.dart';
import '../../controllers/providers/error/update_user_profile_error_provider.dart';
import '../../controllers/providers/group/schedule/image_provider.dart';
import '../../controllers/providers/text_field/name_field_provider.dart';
import '../slide/slider/schedule_list_and_joined_group_tab_slider.dart';

class SaveButton extends ConsumerStatefulWidget {
  const SaveButton({super.key, required this.name});
  final String name;

  @override
  ConsumerState createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  void _loadingProgress(bool loading) {
    LoadingProgressController.loadingProgress(ref, loading: loading);
  }

  Future<String?> _update() async {
    return UpdateUserProfile.update(
      ref.watch(nameFieldProvider(widget.name)).text,
      ref.watch(imageControllerProvider),
      null,
      ref,
    );
  }

  Future<void> _pushAndRemoveUntil() async {
    await Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
        builder: (context) => const ScheduleListAndJoinedGroupTabSlider(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> save() async {
      if (ref.watch(loadingProgressProvider)) {
        return;
      }

      _loadingProgress(true);
      final errorMessage = await _update();
      _loadingProgress(false);
      if (errorMessage != null) {
        ref.watch(updateUserProfileErrorMessageProvider.notifier).state =
            errorMessage;
        return;
      }

      if (!mounted) {
        return;
      }
      await _pushAndRemoveUntil();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: CupertinoButton(
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
                  color: CupertinoColors.white,
                ),
                child: const Icon(
                  CupertinoIcons.arrow_down_doc,
                  color: CupertinoColors.black,
                ),
              ),
              const SizedBox(width: 10),
              const Text('変更を保存'),
            ],
          ),
        ),
      ),
    );
  }
}
