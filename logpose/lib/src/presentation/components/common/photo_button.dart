import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../handlers/photo_button_handler.dart';

class PhotoButton extends ConsumerStatefulWidget {
  const PhotoButton({super.key});
  @override
  ConsumerState<PhotoButton> createState() => _PhotoButtonState();
}

class _PhotoButtonState extends ConsumerState<PhotoButton> {
  Future<void> _handlePhoto() async {
    final handler = PhotoButtonHandler(context: context, ref: ref);
    await handler.handlePhoto();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _handlePhoto,
      child: const SizedBox(
        child: Icon(
          CupertinoIcons.photo,
          size: 60,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
