import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/group/schedule/image_provider.dart';
import '../../image/custom_image.dart';

class GroupImageView extends ConsumerStatefulWidget {
  const GroupImageView({super.key});
  @override
  ConsumerState<GroupImageView> createState() => _GroupImageViewState();
}

class _GroupImageViewState extends ConsumerState<GroupImageView> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final imageController = ref.watch(imageControllerProvider);
    return imageController.path == ''
        ? Icon(
            CupertinoIcons.group_solid,
            size: deviceWidth * 0.17,
            color: CupertinoColors.systemGrey,
          )
        : CustomImage(
            imagePath: imageController.path,
            width: deviceWidth * 0.17,
            height: deviceHeight * 0.0765,
          );
  }
}
