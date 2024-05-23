import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../notifiers/image_provider.dart';

import '../../../../../common/custom_image/custom_image.dart';

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
    final imageNotifier = ref.watch(imageControllerProvider);

    final imagePath = imageNotifier.path == '' && widget.imagePath != null
        ? widget.imagePath!
        : imageNotifier.path;

    return CustomImage(
      width: deviceWidth * 0.17,
      height: deviceHeight * 0.0765,
      imagePath: imagePath,
    );
  }
}
