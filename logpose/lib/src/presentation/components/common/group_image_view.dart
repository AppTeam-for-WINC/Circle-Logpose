import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/providers/group/schedule/image_provider.dart';
import 'custom_image/custom_image.dart';

class GroupImageView extends ConsumerStatefulWidget {
  const GroupImageView({super.key, this.imagePath});
  final String? imagePath;

  @override
  ConsumerState<GroupImageView> createState() => _GroupImageViewState();
}

class _GroupImageViewState extends ConsumerState<GroupImageView> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    String imagePath;
    if (ref.watch(imageControllerProvider).path == '' &&
        widget.imagePath != null) {
      imagePath = widget.imagePath!;
    } else {
      imagePath = ref.watch(imageControllerProvider).path;
    }

    return imagePath == ''
        ? Icon(
            CupertinoIcons.group_solid,
            size: deviceWidth * 0.17,
            color: CupertinoColors.systemGrey,
          )
        : CustomImage(
            imagePath: imagePath,
            width: deviceWidth * 0.17,
            height: deviceHeight * 0.0765,
          );
  }
}
