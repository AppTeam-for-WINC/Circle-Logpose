import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/custom_image/custom_image.dart';
import '../../controllers/providers/group/schedule/image_provider.dart';

class UserImageView extends ConsumerStatefulWidget {
  const UserImageView({super.key, required this.imagePath});
  final String? imagePath;

  @override
  ConsumerState<UserImageView> createState() => _UserImageViewState();
}

class _UserImageViewState extends ConsumerState<UserImageView> {
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

    return CustomImage(
      width: deviceWidth * 0.17,
      height: deviceHeight * 0.0765,
      imagePath: imagePath,
    );
  }
}
